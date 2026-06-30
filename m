Return-Path: <linux-wireless+bounces-38352-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1SY6OrqqQ2pqegoAu9opvQ
	(envelope-from <linux-wireless+bounces-38352-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:38:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 681A26E3B32
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 13:38:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=b9bL17tg;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38352-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38352-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7186732057B8
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jun 2026 11:03:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9053F39FD;
	Tue, 30 Jun 2026 10:59:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A87F3EFFDD;
	Tue, 30 Jun 2026 10:59:27 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782817169; cv=none; b=JSYZNyEJnDqDaXDfqiS2pAJjjiexOAHbpsAglhrjdkbEUhv/bhljFoNK0GLWVTcSWcbobsgplR8xhfaUIaR1//mdkR57NXYpjCmTvedXqhFjvC+zgdu2gI6tC/mihbbEszcwsF+IjYa3ByRL1w2OcKNsTML+Y9Av2vZIbhUUfd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782817169; c=relaxed/simple;
	bh=amv7aRZ4RhdZ4gGs+RicBui7CHgW6xzxoajwsYUqCU8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ae6yxsuId1ypVTl8j+4AqttT6+65DR855p+dsac1cpg1KGH4IZmemWouImVGWdXa6OmECwk2o6YophrmUO50HTMMUxc/HOwTA3buhq2Xx6cZa/31bhnTf3TMKE1IMvc/KVFjZJbjXE7+JkkJHmJNKMWo/DmemliIKxrjkYe7k7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b9bL17tg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4A31F000E9;
	Tue, 30 Jun 2026 10:59:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782817167;
	bh=/60oaCW2BQae8L1Ed3jr0q0Fd1+merS/wb25bNKYVmA=;
	h=From:Subject:Date:To:Cc;
	b=b9bL17tgX9g/0VWgldenTIgpoi2fQRFDuEHc7FExVmS+6DkVl65hZBJImOgYFJX+b
	 YJO18n/S4id56u9kjbmBjTHiscZwwq3pQL7DcehaGvyp5PmPxTvIPjMD1ZUtGMp/Hk
	 tS8+tmTA+wc0TXD6U9QAorrRL7GRWN72GGJ0ziqgp91Sa2+l38toe7uxR6Y3gy5AW+
	 WQVZ9yPo7tiHLFokWgMD0t2Sb1Etya7v78Q+6IFfOdPfQDcQc+IhRChSZ9lvmpCmz7
	 10Llg8Ddec0qLa+tZnjZlnkUMGYQgmjcbTGtBt3K54SCLkjnwhH3RPIpJTs0ET4Pp3
	 2Kv+U1cljNjKw==
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Subject: [PATCH net-next 0/8] drivers/net: replace __get_free_pages() with
 kmalloc()
Date: Tue, 30 Jun 2026 13:59:19 +0300
Message-Id: <20260630-b4-drivers-net-v1-0-672162a91f37@kernel.org>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIehQ2oC/yWMQQ7CMAwEv1L5TERahVTiK4hD7DrUHAKyS1Wp6
 t9J4Li7s7ODsQobXLsdlFcxeZUa+lMHNKfyYCdTzTD4IfrYR4fBTSorq7nCi8s05guO7FMgqKe
 3cpbtJ7xBAwpvC9z/i33wybQ0X2MxGTvUVGhuFYazkQkcxxdv1FOalgAAAA==
X-Change-ID: 20260616-b4-drivers-net-fc7f5b7e0a4c
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Brian Norris <briannorris@chromium.org>, 
 Edward Cree <ecree.xilinx@gmail.com>, 
 Francesco Dolcini <francesco@dolcini.it>, 
 Manish Chopra <manishc@marvell.com>, Mike Rapoport <rppt@kernel.org>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Sudarsana Kalluru <skalluru@marvell.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, b43-dev@lists.infradead.org, 
 intel-wired-lan@lists.osuosl.org, libertas-dev@lists.infradead.org, 
 linux-kernel@vger.kernel.org, linux-mm@kvack.org, linux-net-drivers@amd.com, 
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-38352-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:briannorris@chromium.org,m:ecree.xilinx@gmail.com,m:francesco@dolcini.it,m:manishc@marvell.com,m:rppt@kernel.org,m:przemyslaw.kitszel@intel.com,m:skalluru@marvell.com,m:anthony.l.nguyen@intel.com,m:b43-dev@lists.infradead.org,m:intel-wired-lan@lists.osuosl.org,m:libertas-dev@lists.infradead.org,m:linux-kernel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-net-drivers@amd.com,m:linux-wireless@vger.kernel.org,m:netdev@vger.kernel.org,m:andrew@lunn.ch,m:ecreexilinx@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[rppt@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rppt@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_CC(0.00)[chromium.org,gmail.com,dolcini.it,marvell.com,kernel.org,intel.com,lists.infradead.org,lists.osuosl.org,vger.kernel.org,kvack.org,amd.com];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 681A26E3B32

This is a (small) part of larger work of replacing page allocator calls
with kmalloc.

My initial intention a few month ago was to remove ugly casts [1], but then
willy pointed out that Linus objected to something like this [2] and it
looks like more than a decade old technical debt.

Largely, anything that doesn't need struct page (or a memdesc in the
future) should just use kmalloc() or kvmalloc() to allocate memory.
kmalloc() guarantees alignment, physical contiguity and working
virt_to_phys() and beside nicer API that returns void * on alloc and
doesn't require to know the allocation size on free, kmalloc() provides
better debugging capabilities than page allocator.

Another thing is that touching these allocation sites gives the reviewers
opportunity to see if a PAGE_SIZE buffer is actually needed or maybe
another size is appropriate.

For larger allocations that don't need physically contiguous memory
kvmalloc() can be a better option that __get_free_pages() because under
memory pressure it's is easier to allocate several order-0 pages than a
physically contiguous chunk with the same number of pages.

And last, but not least, removing needless calls to page allocator should
help with memdesc (aka project folio) conversion. There will be way less
places to audit to see if the user was actually using struct page.

Also in git:
https://git.kernel.org/pub/scm/linux/kernel/git/rppt/linux.git gfp-to-kmalloc/drivers-net

[1] https://lore.kernel.org/all/20251018093002.3660549-1-rppt@kernel.org/
[2] https://lore.kernel.org/all/CA+55aFwp4iy4rtX2gE2WjBGFL=NxMVnoFeHqYa2j1dYOMMGqxg@mail.gmail.com/

---
Mike Rapoport (Microsoft) (8):
      b43, b43legacy: debugfs: use kmalloc() to allocate formatting buffers
      bnx2x: use kzalloc() to allocate mac filtering list
      ice: use kzalloc() to allocate staging buffer for reading from GNSS
      libertas: debugfs: use kzalloc() to allocate formatting buffers
      mwifiex: debugfs: use kzalloc() to allocate formatting buffers
      sfc/siena: use kmalloc() to allocate logging buffer
      sfc: use kmalloc() to allocate logging buffer
      wlcore: allocate aggregation and firmware log buffers with kzalloc()

 drivers/net/ethernet/broadcom/bnx2x/bnx2x_sp.c    |  6 +--
 drivers/net/ethernet/intel/ice/ice_gnss.c         |  5 +-
 drivers/net/ethernet/sfc/mcdi.c                   |  7 +--
 drivers/net/ethernet/sfc/siena/mcdi.c             |  7 +--
 drivers/net/wireless/broadcom/b43/debugfs.c       | 12 ++---
 drivers/net/wireless/broadcom/b43legacy/debugfs.c | 11 ++--
 drivers/net/wireless/marvell/libertas/debugfs.c   | 39 ++++++--------
 drivers/net/wireless/marvell/mwifiex/debugfs.c    | 62 ++++++++++-------------
 drivers/net/wireless/ti/wlcore/main.c             | 14 +++--
 9 files changed, 73 insertions(+), 90 deletions(-)
---
base-commit: dc59e4fea9d83f03bad6bddf3fa2e52491777482
change-id: 20260616-b4-drivers-net-fc7f5b7e0a4c

Best regards,
--  
Sincerely yours,
Mike.


