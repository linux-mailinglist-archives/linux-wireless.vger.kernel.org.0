Return-Path: <linux-wireless+bounces-34009-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OH/WCE2hxWlUAQUAu9opvQ
	(envelope-from <linux-wireless+bounces-34009-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:12:45 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97FA133BB39
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 22:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A23B3013EE1
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Mar 2026 21:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E2723A6F16;
	Thu, 26 Mar 2026 21:12:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b="E0sMQAhh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="UeIXJwOp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from flow-a1-smtp.messagingengine.com (flow-a1-smtp.messagingengine.com [103.168.172.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AD2739DBD8;
	Thu, 26 Mar 2026 21:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774559552; cv=none; b=E+CwTuNQ3AXZLfC0eOPMHpg0adwAHMgTO7OvJxwQQsM9GMsjNX4KEUkq1FY739tKk2/Ah0kFCLUDjSKxKP3+ZAIJYgnH45pP3b6qAhX5PlTHg/HqDKWNZcmn9zYXNDi++u75CR57fjYdRGdoRFvFd9ru3bBjyN1eFDvlvhySmkM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774559552; c=relaxed/simple;
	bh=DizT/ddlZFD7KX9YeoKrBVdFFWkgs3dXjw0pBgdRG1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc:
	 In-Reply-To:References; b=T/HeF8AB7c1NwjY/2xmygOUaBVynzJtUxouWk6RLUM8PMR7HLuS2JLEdYWjxU5ANEohBwOZcbBFbD4jlDYGF9XsKa5nDtphJ8bnjJ+WNijMOw5A3W4Hhb/UBE8LEU8Mj9gXbIcMVKB+Mh4TrOxr1xRd6GVHCNgv2EGj9g2EWujE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me; spf=pass smtp.mailfrom=jetm.me; dkim=pass (2048-bit key) header.d=jetm.me header.i=@jetm.me header.b=E0sMQAhh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=UeIXJwOp; arc=none smtp.client-ip=103.168.172.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=jetm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=jetm.me
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailflow.phl.internal (Postfix) with ESMTP id 70588138014E;
	Thu, 26 Mar 2026 17:12:30 -0400 (EDT)
Received: from phl-imap-07 ([10.202.2.97])
  by phl-compute-02.internal (MEProxy); Thu, 26 Mar 2026 17:12:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=jetm.me; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1774559550;
	 x=1774566750; bh=cvt3lJ9bUn/nS9x0h5+rL6WI6mE1I309IFcyKJoRia4=; b=
	E0sMQAhh0TkOQjOZsniK4kPP1PcoLWV2KYRNxET3sGKeLs16s1BbfxFO8/aQQ/lX
	l7XQushoQdALzy6LAp0eo+EtZSHskCUa7mQjZU+A/GlEOH2jr2jj1WTFsl1f6Re9
	j/VHZBhBw+yKeW+vl2ECZyhI3TPznv+iGkcgU6BvVyr1rIYehcyMUc8HdCPvJ51D
	Gblbvcp/tqX6QIdhU0HMb9vBl7FsrD8LR7JdCvDPlAwkvqJ78t4HLftLk8CCi8ZQ
	qmVvKdQUKy7fdu8TmrHOoIJ//eZikstkzzQ288/JEx+FlqVO+fcxilJKMYc+PFmw
	MEFVVT4Fo7JPfmg40FAgrA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1774559550; x=
	1774566750; bh=cvt3lJ9bUn/nS9x0h5+rL6WI6mE1I309IFcyKJoRia4=; b=U
	eIXJwOpPl3cUAUutZr89x1lkdQUbj+f97ECwm3X08pHjAj7+fd1N0k1Pu/MGbSQC
	lNyJLGq1vd0ynJlViIC6Lu8QctAlqV5cUIffff+OSLobUPRp8zX5H5UTIcJshDvD
	D4K3952AzOTtGul///Umvd3ojJFl9B/Bi+Af8xT8Ne0CJzrv3aZpl+DM1CESl6aO
	ZgCZjpIHdmZoE9sZ8BByJH+WBiAlgLe7zl79YL4NhitK0SIm4VTzq5LEYl+fcrip
	S+mBkVyOQXmsv1lnnGfGMKrpz4xIVXVDDZkrpAkZmhpdiYhU+ndCU6jBvhCzmJvt
	1kwRpG1Sm6nQqe7i4HEkg==
X-ME-Sender: <xms:PqHFafTCv14r9Z8C2kY4sXjmydl1wZ81kMcwniCKdz0Slzj3ap_sjg>
    <xme:PqHFabkNTM3vPcmWd8n9TcPgUYiC-GBjszCaazHqOsCGlcez7F8zDWOiXCRHM-0bu
    g5vTUKsSA5BDXanQVlStDHD-DVNdUwagux3HNM4Lp9dHt4tMKdysca9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefvdekgedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepoffhfffugggtgffkvfevofgjfhesthekredtredtjeenucfhrhhomheplfgrvhhi
    vghrucfvihgruceofhhlohhsshesjhgvthhmrdhmvgeqnecuggftrfgrthhtvghrnhepve
    ektdfhffevuddtgfetieevtddvheduhfeggfekveejlefhleefieevueefiefhnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepfhhlohhsshesjh
    gvthhmrdhmvgdpnhgspghrtghpthhtohepvddvpdhmohguvgepshhmthhpohhuthdprhgt
    phhtthhopegrnhhgvghlohhgihhorggttghhihhnohdruggvlhhrvghgnhhosegtohhllh
    grsghorhgrrdgtohhmpdhrtghpthhtohepfeduleefieefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehlohhonhhgrddtgidttdesghhmrghilhdrtghomhdprhgtphhtthhope
    grrhhivghlrdhrohhsvghnfhgvlhgurdejhedtsehgmhgrihhlrdgtohhmpdhrtghpthht
    oheptghhrghpuhhishgurghrihhogeesghhmrghilhdrtghomhdprhgtphhtthhopehgih
    hoshgrlheltdesghhmrghilhdrtghomhdprhgtphhtthhopehmrghtthhhihgrshdrsghg
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehrrgguohhirdgthhhrihhssehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepshgrmhhurdhtohhljhgrmhhosehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:PqHFaTtAOz4aOfWggrf5KjVy9M5banF0TJvUweQ8RF22uGxaFIE3HQ>
    <xmx:PqHFacHTChNx9UTg-nCk_csUvrA7BQpEMJ-4QQIC26w6_zIsIIatIQ>
    <xmx:PqHFaW-WkH8SD5QpnZGZx6Hz8KOyZ8t1ZBmpEuuZbg1wjcrX4do12Q>
    <xmx:PqHFaaOszY5rM73JBCnsGI64_qB06PUu8KqOlgrJ5OlFAcaS_XSYjA>
    <xmx:PqHFaUYeyHNZYkcgiNhsjzekf6HGnkUuVss6OpUBaO7Eivr_OO6Hd4BB>
Feedback-ID: i9dde48b3:Fastmail
Received: by mailuser.phl.internal (Postfix, from userid 501)
	id 4263E1EA006B; Thu, 26 Mar 2026 17:12:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
From: Javier Tia <floss@jetm.me>
Date: Thu, 26 Mar 2026 15:12:25 -0600
Subject: [PATCH v4 1/9] wifi: mt76: mt7925: fix stale pointer comparisons
 in change_vif_links
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20260326-mt7927-wifi-support-v4-v4-1-8ab465addcfe@jetm.me>
To: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>,
 Ryder Lee <ryder.lee@mediatek.com>, Shayne Chen <shayne.chen@mediatek.com>,
 Sean Wang <sean.wang@mediatek.com>,
 Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
 Deren Wu <deren.wu@mediatek.com>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org,
 Marcin FM <marcin@lgic.pl>, Cristian-Florin Radoi <radoi.chris@gmail.com>,
 George Salukvadze <giosal90@gmail.com>, Evgeny Kapusta <3193631@gmail.com>,
 Samu Toljamo <samu.toljamo@gmail.com>,
 Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>,
 Chapuis Dario <chapuisdario4@gmail.com>,
 =?utf-8?q?Thibaut_Fran=C3=A7ois?= <tibo@humeurlibre.fr>,
 =?utf-8?q?=E5=BC=A0=E6=97=AD=E6=B6=B5?= <Loong.0x00@gmail.com>
X-Mailer: b4 0.15.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1810; i=floss@jetm.me;
 h=from:subject:message-id; bh=DizT/ddlZFD7KX9YeoKrBVdFFWkgs3dXjw0pBgdRG1k=;
 b=owEB7QES/pANAwAKAbXuwwuoZ3cfAcsmYgBpxaE4l7WE3ZFIZQ9RG3yAHeILkdCfnys0Gihiz
 L5KH/OLmTGJAbMEAAEKAB0WIQSbE7ILzw7eI0VKk8m17sMLqGd3HwUCacWhOAAKCRC17sMLqGd3
 H6leC/9wtLfOoljzuG6wmMdGF3XfSkujHVEyLZ7StGb+C/pcFHrJw51iyUKFHqVDc8GKLXuNsDw
 F+V+tlL5kgouXGeuHOJgQvwlYiH94+rOhaZr7a8bYBsMH2f4nX+A8IkN101/fhR8b3YebcI3U8d
 5dQy0T78MBfVBINaqJoAK/nfPvh/PFiUu1JUeiuIK4k+qGyzYmuxPgS4ig1+AWLUizhM/0QLAeD
 kXL2AjMaSH/Nb7pRNDe/+QGYAmyrbQljZdMgWD+LRpJv6e2n/lmIdPEzhGkcO8VgRqQ0Z8l1ZSX
 7d5t3zLQE8UH6DiMDT5IxczbMy+5fymEZXiIUvEKnO9iQKKwKBAkJQqQHCCxFWPUYv/ZHIoN3s4
 6K67Gtgrvgyz6NohMT+YBSeZla9BqRz+BGGdWFEQNp+Ca9VjmsZUXN4Pvx7Ko1vbOC3xKdk6bLX
 1SYAq6yVY9YJAm6FILWRrh8jyzsFk4qzYTkQ4u1xsr7syvOos30wnHfNRjEXhb8h8HMQw=
X-Developer-Key: i=floss@jetm.me; a=openpgp;
 fpr=9B13B20BCF0EDE23454A93C9B5EEC30BA867771F
In-Reply-To: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
References: <20260326-mt7927-wifi-support-v4-v4-0-8ab465addcfe@jetm.me>
X-Spamd-Result: default: False [-0.65 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[jetm.me,quarantine];
	R_DKIM_ALLOW(-0.20)[jetm.me:s=fm3,messagingengine.com:s=fm1];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	XM_UA_NO_VERSION(0.01)[];
	TAGGED_FROM(0.00)[bounces-34009-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.infradead.org,lgic.pl,gmail.com,humeurlibre.fr];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[floss@jetm.me,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[jetm.me:+,messagingengine.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,jetm.me:dkim,jetm.me:email,jetm.me:mid,messagingengine.com:dkim,lgic.pl:email,humeurlibre.fr:email]
X-Rspamd-Queue-Id: 97FA133BB39
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

In the error path of mt7925_change_vif_links(), the free: label iterates
over link_ids to clean up, but compares against `mconf` and `mlink`
which hold stale values from the last loop iteration rather than the
current link_id being freed.

Use array-indexed access (mconfs[link_id] / mlinks[link_id]) to compare
against the correct per-link pointers.

Fixes: 69acd6d910b0 ("wifi: mt76: mt7925: add mt7925_change_vif_links")
Tested-by: Marcin FM <marcin@lgic.pl>
Tested-by: Cristian-Florin Radoi <radoi.chris@gmail.com>
Tested-by: George Salukvadze <giosal90@gmail.com>
Tested-by: Evgeny Kapusta <3193631@gmail.com>
Tested-by: Samu Toljamo <samu.toljamo@gmail.com>
Tested-by: Ariel Rosenfeld <ariel.rosenfeld.750@gmail.com>
Tested-by: Chapuis Dario <chapuisdario4@gmail.com>
Tested-by: Thibaut François <tibo@humeurlibre.fr>
Tested-by: 张旭涵 <Loong.0x00@gmail.com>
Signed-off-by: Javier Tia <floss@jetm.me>
---
 drivers/net/wireless/mediatek/mt76/mt7925/main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 2d358a96640c..f128a198f81d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -2047,9 +2047,9 @@ mt7925_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		rcu_assign_pointer(mvif->link_conf[link_id], NULL);
 		rcu_assign_pointer(mvif->sta.link[link_id], NULL);
 
-		if (mconf != &mvif->bss_conf)
+		if (mconfs[link_id] != &mvif->bss_conf)
 			devm_kfree(dev->mt76.dev, mconfs[link_id]);
-		if (mlink != &mvif->sta.deflink)
+		if (mlinks[link_id] != &mvif->sta.deflink)
 			devm_kfree(dev->mt76.dev, mlinks[link_id]);
 	}
 

-- 
2.53.0


