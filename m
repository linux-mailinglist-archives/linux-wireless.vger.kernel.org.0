Return-Path: <linux-wireless+bounces-32132-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CDjgDCvnnGmNMAQAu9opvQ
	(envelope-from <linux-wireless+bounces-32132-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 00:47:55 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAA017FF75
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Feb 2026 00:47:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 54C8930E78F7
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 23:45:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E930037FF69;
	Mon, 23 Feb 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dKvppV09"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51E434C830
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 23:45:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771890340; cv=none; b=MEXsBe6vaTkzmcigMQQ2j4jhzX+47dlsW+tY7g7lQs54lusmIFoYWfJS0HGdI0q5xfvzrWuFF6WWfPmy4M31Z1YNai9vIgbWMrvZd4wk2vhRWUe1iw6Gj5GVnWvXRgBA0eOb/YlLV7CqU/I6jS1HkWS4Y0aKjzwlfC4lPtfDlCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771890340; c=relaxed/simple;
	bh=dMJAamPMttQVB14LwejzQz8So/iEKZx4aqjj7wWaGLE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y0lVNJ26n7O878ln3jajVWu1DZVozAMMxLAX7XH4vfDgnz6CQWCnp2X2xfYwHIWiPRT20pPjB6ylYOi51thBCmr5Og88pXq2hkqpKvyWsHlMKlAs37yUsYwCzVpRkDiaT5BQVauiNM+YzFrnTqfcBqeZXR/sI2zdTRjhBPpo3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dKvppV09; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55DCCC2BC86
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 23:45:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771890340;
	bh=dMJAamPMttQVB14LwejzQz8So/iEKZx4aqjj7wWaGLE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=dKvppV09RjBX6b6vaSCFlO+cqIJLW17qvrkHfNA5nurOQFpPPKxVu7cuf1OK+b7ZC
	 uZiH5g1yVEY0smI1Nlshl2yMfBrzALVWVHeekZLD8WKBdxtwcwGxGiuGTUxAutFrhf
	 O6lI2AysC6lt2bf/HIFKr5nWyyh7ObVRKXJ2GUh78+D6kQlzpXFsosYb75m9QLletA
	 1VeFof+rRJ+/dgXNPUh5rgNTwkVwC8x8m8FagLvyNXJT1uSNqFu5hs4tACghU2uWax
	 liA3FOZBt7wXHOngx7o8r3HWC44VYOLpZCO/u/lAJJJs7SKqu3rrEVbKFbqj5b7fWO
	 ENz8qidfiv8SQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so4654189e87.2
        for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 15:45:40 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVURCzegpe1tTsCstZinJ3991yIZ6KwAeTpdPC7R42E0Yb2R4biqPkd5Sy30poy2+PNOnwojQ57tv4JU1u0vQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWvQf/c+yGqY64cAk/hVDX8S93c3TC/whNWMI8u5fxvuGwbY/g
	Y1/xHN5LDdqhN2ZmPm1fsmWgciWlDg2ruwhI2HOfhc7wUwzdg7k1uDpSJbwHPkrU8lA5qiUjHu1
	svIkoy8H8t+3AWnfbUoChL0eLcQKxEOw=
X-Received: by 2002:a05:6512:1302:b0:5a0:4cb8:f51 with SMTP id
 2adb3069b0e04-5a0ed882ca6mr3293363e87.19.1771890338723; Mon, 23 Feb 2026
 15:45:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260223073854.2464232-1-jb.tsai@mediatek.com> <20260223073854.2464232-4-jb.tsai@mediatek.com>
In-Reply-To: <20260223073854.2464232-4-jb.tsai@mediatek.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Mon, 23 Feb 2026 17:45:26 -0600
X-Gmail-Original-Message-ID: <CAGp9LzpWqW7NL4iHMVLHqqUg6wpWabfQLnL9ssGpvx+zYgecgw@mail.gmail.com>
X-Gm-Features: AaiRm52dg97jQQvqRnAJZAe4VN-LKok6GIs3rgj8_wkg-i8M5S3cjobbWzDDei8
Message-ID: <CAGp9LzpWqW7NL4iHMVLHqqUg6wpWabfQLnL9ssGpvx+zYgecgw@mail.gmail.com>
Subject: Re: [PATCH 4/5] wifi: mt76: mt7921: add auto regdomain switch support
To: JB Tsai <jb.tsai@mediatek.com>
Cc: nbd@nbd.name, lorenzo@kernel.org, linux-wireless@vger.kernel.org, 
	linux-mediatek@lists.infradead.org, Deren.Wu@mediatek.com, 
	Sean.Wang@mediatek.com, Quan.Zhou@mediatek.com, Ryder.Lee@mediatek.com, 
	Leon.Yen@mediatek.com, litien.chang@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32132-lists,linux-wireless=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mediatek.com:email]
X-Rspamd-Queue-Id: 5EAA017FF75
X-Rspamd-Action: no action

Hi, JB

On Mon, Feb 23, 2026 at 1:40=E2=80=AFAM JB Tsai <jb.tsai@mediatek.com> wrot=
e:
>
> Implement 802.11d-based automatic regulatory domain switching to
> dynamically determine the regulatory domain at runtime.
>
> Signed-off-by: JB Tsai <jb.tsai@mediatek.com>
> ---
>  .../wireless/mediatek/mt76/mt76_connac_mcu.h  |  3 +-
>  .../net/wireless/mediatek/mt76/mt7921/mac.c   |  3 +
>  .../net/wireless/mediatek/mt76/mt7921/main.c  | 12 ++-
>  .../net/wireless/mediatek/mt76/mt7921/mcu.c   |  3 +-
>  .../net/wireless/mediatek/mt76/mt7921/regd.c  | 81 +++++++++++++++++--
>  .../net/wireless/mediatek/mt76/mt7921/regd.h  |  2 +
>  6 files changed, 93 insertions(+), 11 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drive=
rs/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> index f44977f9093d..263778be4a34 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> +++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
> @@ -1586,7 +1586,7 @@ struct mt76_connac_hw_scan_done {
>         u8 pno_enabled;
>         u8 pad2[3];
>         u8 sparse_channel_valid_num;
> -       u8 pad3[3];
> +       u8 alpha2[3];
>         u8 channel_num[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
>         /* idle format for channel_idle_time
>          * 0: first bytes: idle time(ms) 2nd byte: dwell time(ms)
> @@ -1599,6 +1599,7 @@ struct mt76_connac_hw_scan_done {
>         u8 mdrdy_count[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_NUM];
>         __le32 beacon_2g_num;
>         __le32 beacon_5g_num;
> +       __le16 channel_scan_time[MT76_CONNAC_SCAN_DONE_EVENT_MAX_CHANNEL_=
NUM];
>  } __packed;
>
>  struct mt76_connac_sched_scan_req {
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/ne=
t/wireless/mediatek/mt76/mt7921/mac.c
> index 03b4960db73f..bcca4b17e8f2 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
> @@ -7,6 +7,7 @@
>  #include "mt7921.h"
>  #include "../dma.h"
>  #include "../mt76_connac2_mac.h"
> +#include "regd.h"
>  #include "mcu.h"
>
>  #define MT_WTBL_TXRX_CAP_RATE_OFFSET   7
> @@ -697,6 +698,8 @@ void mt7921_mac_reset_work(struct work_struct *work)
>                                             IEEE80211_IFACE_ITER_RESUME_A=
LL,
>                                             mt7921_vif_connect_iter, NULL=
);
>         mt76_connac_power_save_sched(&dev->mt76.phy, pm);
> +
> +       mt7921_regd_change(&dev->phy, "00");
>  }
>
>  void mt7921_coredump_work(struct work_struct *work)
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/n=
et/wireless/mediatek/mt76/mt7921/main.c
> index 00ca3d3f3ef0..dfe8cbd7dfa5 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -1027,8 +1027,16 @@ void mt7921_scan_work(struct work_struct *work)
>                 rxd =3D (struct mt76_connac2_mcu_rxd *)skb->data;
>                 if (rxd->eid =3D=3D MCU_EVENT_SCHED_SCAN_DONE) {
>                         ieee80211_sched_scan_results(phy->mt76->hw);
> -               } else if (test_and_clear_bit(MT76_HW_SCANNING,
> -                                             &phy->mt76->state)) {
> +               } else if (rxd->eid =3D=3D MCU_EVENT_SCAN_DONE) {
> +                       struct mt76_connac_hw_scan_done *event =3D NULL;
> +
> +                       skb_pull(skb, sizeof(*rxd));
> +                       event =3D (struct mt76_connac_hw_scan_done *)skb-=
>data;
> +                       mt7921_regd_change(phy, event->alpha2);

Because this changes the firmware/driver ABI, we need to consider
backward compatibility. Will the driver still behave correctly with
older firmware?
For example, on older firmware the scan-done event doesn=E2=80=99t populate
alpha2 (it would effectively be coming from the old pad3 field and may
contain undefined bytes).

> +               }
> +
> +               if (test_and_clear_bit(MT76_HW_SCANNING,
> +                                      &phy->mt76->state)) {
>                         struct cfg80211_scan_info info =3D {

