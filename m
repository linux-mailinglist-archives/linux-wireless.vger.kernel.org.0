Return-Path: <linux-wireless+bounces-37577-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id OqaENCHwJ2rY5wIAu9opvQ
	(envelope-from <linux-wireless+bounces-37577-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:51:13 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 70E9D65F24A
	for <lists+linux-wireless@lfdr.de>; Tue, 09 Jun 2026 12:51:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=fail ("headers rsa verify failed") header.d=nbd.name header.s=20160729 header.b=V4f+UOaj;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37577-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37577-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=fail reason="SPF not aligned (relaxed)" header.from=nbd.name (policy=none);
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D35F83008243
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 10:51:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2A23F9296;
	Tue,  9 Jun 2026 10:51:10 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5626238E119
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 10:51:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781002270; cv=none; b=Ds4dSbaU35NHNlXgMYLJSQVGUJKOwFU1fqzUUrtzQjd+yYuV+mCm4tHoWzKqkOWbKwWey0RL2sPf7Mpfudv/rlDsaKD9+Lh4asbn3uKjDgHbMyf2X5u0WPAwayYsm1Hqh3OEoGQoKjuozib2xK1BEdCU5qNpIOhx3GXkf98baxs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781002270; c=relaxed/simple;
	bh=o+LRpqG3cBD2nUI8O7NEK9t91vqP26+Ye0nXSbzV3jc=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=XBnXEC6We6qJ8pf32GRhFH8zcZiBvKOBAnk2VBzQjfCCJWeF394p3TEk0eG5KkDCbQlZtdk5JchNGdVqOQ+KCMo48ujJrLXsUzNR7Cg7uauW7f5DnTPbO+OBgFavRQSjAdMh5yEZ1EkDJboluO21cFWdj6CZqvPUB0iJUtRF8kU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=pass smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=V4f+UOaj; arc=none smtp.client-ip=46.4.11.11
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:Cc:To:Subject:From:
	MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=mxjdE5jArjp0s9bp+48yUDd4F2tKrHXb9NYg+9DzstE=; b=V4f+UOaj6fQllAYRN1uc/gHrLn
	OOySHI7ylSrIDAwySP2JK/CJPS4JdLHuf75HaWOvSG4vCeese9Bjm+RoEDKXj1dWod//rfycRZAxj
	yL+r5qy6INcPl9wTSL93Xfvu6DCCDJ/DjPW5PtSLgZVrLIJpIXmUy7+Hm1wM3lUKbPE8=;
Received: from p5b01517e.dip0.t-ipconnect.de ([91.1.81.126] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1wWu2t-00BxUd-1j;
	Tue, 09 Jun 2026 12:50:59 +0200
Message-ID: <04a7f98a-6992-4497-8123-4ea440b97759@nbd.name>
Date: Tue, 9 Jun 2026 12:50:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Felix Fietkau <nbd@nbd.name>
Subject: pull request: mt76-next 2026-06-09
To: linux-wireless <linux-wireless@vger.kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	R_DKIM_REJECT(1.00)[nbd.name:s=20160729];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[nbd.name : SPF not aligned (relaxed),none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-wireless@vger.kernel.org,m:johannes@sipsolutions.net,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWO(0.00)[2];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-37577-lists,linux-wireless=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nbd@nbd.name,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[nbd.name:-];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 70E9D65F24A

Hi,

Here's my mt76 pull request for 7.2

- Felix

The following changes since commit b224d18b1e5d1cddfc67f63f41d80023b2ec8889:

   wifi: mac80211: bound S1G TIM PVB walk to the TIM element (2026-06-08 08:59:03 +0200)

are available in the Git repository at:

   https://github.com/nbd168/wireless tags/mt76-next-2026-06-09

for you to fetch changes up to 50a7f9f9d48eb50c0e95bef53358acb5af5cb3c6:

   wifi: mt76: Drop unneeded mt76_register_debugfs_fops() return checks (2026-06-09 10:34:02 +0000)

----------------------------------------------------------------
mt76 patches for 7.2

- fixes
- mt792x broken usb transport detection
- mt7921 regd improvements
- mt7927 support

----------------------------------------------------------------
Arjan van de Ven (1):
       wifi: mt76: mt7921/mt7925: fix NULL dereference in CSA beacon

Aviel Zohar (2):
       wifi: mt76: mt7925: validate skb length in testmode query
       wifi: mt76: mt7915: validate skb length in txpower SKU query

Bjoern A. Zeeb (1):
       wifi: mt76: fix argument to ieee80211_is_first_frag()

Devin Wittmayer (2):
       wifi: mt76: mt7925: add Netgear A8500 USB device ID
       wifi: mt76: mt7921: assert sniffer on chanctx change

Dylan Eskew (2):
       wifi: mt76: mt7996: reduce phy work in set_coverage
       wifi: mt76: mt7996: limit work in set_bitrate_mask

ElXreno (2):
       wifi: mt76: route TDLS-peer frames as 3-addr non-DS in HW encap
       wifi: mt76: mt7925: don't disable AP BSS when removing TDLS peer

Felix Fietkau (2):
       wifi: mt76: mt7996: fix out-of-bounds array access during hardware restart
       wifi: mt76: mt7996: add missing max_remain_on_channel_duration

Hongling Zeng (1):
       wifi: mt76: mt7921: fix resource leak in probe error path

Ingyu Jang (1):
       wifi: mt76: Drop unneeded mt76_register_debugfs_fops() return checks

JB Tsai (5):
       wifi: mt76: mt7921: refactor regulatory domain handling to regd.[ch]
       wifi: mt76: mt7921: refactor CLC support check flow
       wifi: mt76: mt7921: refactor regulatory notifier flow
       wifi: mt76: mt7921: add auto regdomain switch support
       wifi: mt76: mt7921: disable auto regd changes after user set

Javier Tia (9):
       wifi: mt76: mt7925: fix stale pointer comparisons in change_vif_links
       wifi: mt76: mt7925: add 320MHz bandwidth to bss_rlm_tlv
       wifi: mt76: mt7925: handle 320MHz bandwidth in RXV and TXS
       wifi: mt76: mt7925: populate EHT 320MHz MCS map in sta_rec
       wifi: mt76: mt7925: advertise EHT 320MHz capabilities for 6GHz band
       wifi: mt76: mt7925: add MT7927 chip ID helpers
       wifi: mt76: mt7925: add MT7927 firmware paths
       wifi: mt76: mt7925: use irq_map for chip-specific interrupt handling
       wifi: mt76: mt7925: disable ASPM and runtime PM for MT7927

Jiajia Liu (2):
       wifi: mt76: add wcid publish check in mt76_sta_add
       wifi: mt76: transform aspm_conf for pci_disable_link_state

Johan Hovold (5):
       wifi: mt76: drop redundant device reference
       wifi: mt76x0u: drop redundant device reference
       wifi: mt76x2u: drop redundant device reference
       wifi: mt76: mt792xu: drop redundant device reference
       wifi: mt7601u: drop redundant device reference

Lorenzo Bianconi (5):
       wifi: mt76: mt7996: Fix NULL pointer dereference in mt7996_init_tx_queues()
       wifi: mt76: mt7996: Fix possible token leak in mt7996_tx_prepare_skb()
       wifi: mt76: mt7996: Fix possible NULL pointer dereference in mt7996_mac_write_txwi_80211()
       wifi: mt76: mt7996: fix reading zeroed info->control.flags after mt76_tx_status_skb_add()
       wifi: mt76: mt7996: remove redundant pdev->bus check in probe

Myeonghun Pak (1):
       wifi: mt76: mt7925: clean up DMA on probe failure

Rajat Gupta (1):
       wifi: mt76: use kfree_rcu for offchannel link in mt76_put_vif_phy_link

Rosen Penev (1):
       wifi: mt76: fix of_get_mac_address error handling

Ryder Lee (5):
       wifi: mt76: mt7996: disable UNI_BSS_INFO_PROTECT_INFO for mt7996
       wifi: mt76: mt7915: fix potential tx_retries underflow
       wifi: mt76: mt7921: fix potential tx_retries underflow
       wifi: mt76: mt7925: fix potential tx_retries underflow
       wifi: mt76: mt7996: fix potential tx_retries underflow

Sean Wang (22):
       wifi: mt76: connac: replace is_mt7925() with is_connac3()
       wifi: mt76: mt7925: use link-specific removal for non-MLD STA
       wifi: mt76: connac: tolerate inactive BSS deactivation
       wifi: mt76: mt792x: add MT7927 WFSYS reset support
       wifi: mt76: mt792x: factor out common DMA queue allocation
       wifi: mt76: mt7925: switch DMA init to common mt792x queue helpers
       wifi: mt76: mt792x: add MT7927-specific PCIe DMA support
       wifi: mt76: mt7925: sync MT7927 BSS band assignment
       wifi: mt76: mt7925: add MBMC event handling
       wifi: mt76: mt792x: enable CNM ops for MT7927
       wifi: mt76: mt7925: add MT7927 PCIe support
       wifi: mt76: mt7925: add MT7927 USB support
       wifi: mt76: mt7925: keep TX BA state in the primary WCID
       wifi: mt76: mt7925: pass WCID explicitly to mt7925_mcu_sta_ba()
       wifi: mt76: mt7925: program BA state on active links
       wifi: mt76: mt792x: skip MLD header rewrite for 802.3 encap TX
       wifi: mt76: mt7921u: add MT7902 USB support
       wifi: mt76: connac: use a helper to cache txpower_cur
       wifi: mt76: connac: factor out rate power limit calculation
       wifi: mt76: mt792x: report txpower for the requested vif link
       wifi: mt76: mt792x: add common USB transport reset helpers
       wifi: mt76: mt7921u: escalate broken USB transport to device reset

Zenm Chen (1):
       wifi: mt76: mt76x2u: Add support for ELECOM WDC-867SU3S

  drivers/net/wireless/mediatek/mt76/channel.c         |   2 +-
  drivers/net/wireless/mediatek/mt76/eeprom.c          |   2 +-
  drivers/net/wireless/mediatek/mt76/mac80211.c        |  19 ++++--
  drivers/net/wireless/mediatek/mt76/mt76.h            |   1 +
  drivers/net/wireless/mediatek/mt76/mt7615/debugfs.c  |   2 -
  drivers/net/wireless/mediatek/mt76/mt7615/init.c     |   1 -
  drivers/net/wireless/mediatek/mt76/mt7615/usb.c      |   3 -
  drivers/net/wireless/mediatek/mt76/mt76_connac.h     |  21 +++++-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c |  13 +++-
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c |  49 +++++++++++---
  drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  29 ++++++++-
  drivers/net/wireless/mediatek/mt76/mt76x0/usb.c      |   3 -
  drivers/net/wireless/mediatek/mt76/mt76x2/usb.c      |   5 +-
  drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c  |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7915/mac.c      |  10 +--
  drivers/net/wireless/mediatek/mt76/mt7915/main.c     |   3 +
  drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |   8 +++
  drivers/net/wireless/mediatek/mt76/mt7921/Makefile   |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7921/debugfs.c  |   2 -
  drivers/net/wireless/mediatek/mt76/mt7921/init.c     |  98 +---------------------------
  drivers/net/wireless/mediatek/mt76/mt7921/mac.c      |  12 +++-
  drivers/net/wireless/mediatek/mt76/mt7921/main.c     |  29 +++++++--
  drivers/net/wireless/mediatek/mt76/mt7921/mcu.c      |  12 ++--
  drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h   |   1 -
  drivers/net/wireless/mediatek/mt76/mt7921/pci.c      |  20 ++++--
  drivers/net/wireless/mediatek/mt76/mt7921/regd.c     | 206 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
  drivers/net/wireless/mediatek/mt76/mt7921/regd.h     |  19 ++++++
  drivers/net/wireless/mediatek/mt76/mt7921/usb.c      |  11 +++-
  drivers/net/wireless/mediatek/mt76/mt7925/debugfs.c  |   2 -
  drivers/net/wireless/mediatek/mt76/mt7925/init.c     |  12 +++-
  drivers/net/wireless/mediatek/mt76/mt7925/mac.c      |  29 ++++++---
  drivers/net/wireless/mediatek/mt76/mt7925/main.c     | 101 ++++++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      | 116 ++++++++++++++++++++++++++++-----
  drivers/net/wireless/mediatek/mt76/mt7925/mcu.h      |   3 +-
  drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h   |  29 ++++++++-
  drivers/net/wireless/mediatek/mt76/mt7925/pci.c      | 151 +++++++++++++++++++++++++++++++------------
  drivers/net/wireless/mediatek/mt76/mt7925/pci_mac.c  |  12 +++-
  drivers/net/wireless/mediatek/mt76/mt7925/testmode.c |   5 ++
  drivers/net/wireless/mediatek/mt76/mt7925/usb.c      |  22 ++++++-
  drivers/net/wireless/mediatek/mt76/mt792x.h          |  33 ++++++++++
  drivers/net/wireless/mediatek/mt76/mt792x_core.c     |  56 +++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt792x_dma.c      | 198 ++++++++++++++++++++++++++++++++++++++++++++++++++------
  drivers/net/wireless/mediatek/mt76/mt792x_regs.h     |  23 +++++++
  drivers/net/wireless/mediatek/mt76/mt792x_usb.c      |  79 ++++++++++++++++++++++-
  drivers/net/wireless/mediatek/mt76/mt7996/debugfs.c  |   6 +-
  drivers/net/wireless/mediatek/mt76/mt7996/dma.c      |   2 +-
  drivers/net/wireless/mediatek/mt76/mt7996/mac.c      |  51 ++++++---------
  drivers/net/wireless/mediatek/mt76/mt7996/main.c     |  29 +++++----
  drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      |  36 +++++++----
  drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h   |  22 ++++++-
  drivers/net/wireless/mediatek/mt76/mt7996/pci.c      |   2 +-
  drivers/net/wireless/mediatek/mt76/pci.c             |   8 ++-
  drivers/net/wireless/mediatek/mt76/tx.c              |   2 +-
  drivers/net/wireless/mediatek/mt76/usb.c             |   2 +
  drivers/net/wireless/mediatek/mt7601u/usb.c          |   3 -
  55 files changed, 1270 insertions(+), 350 deletions(-)
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.c
  create mode 100644 drivers/net/wireless/mediatek/mt76/mt7921/regd.h

