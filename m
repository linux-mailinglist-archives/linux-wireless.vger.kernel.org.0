Return-Path: <linux-wireless+bounces-35798-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OFfLBMmL92l8iwIAu9opvQ
	(envelope-from <linux-wireless+bounces-35798-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 19:54:17 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E8644B6D8B
	for <lists+linux-wireless@lfdr.de>; Sun, 03 May 2026 19:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8DF543001873
	for <lists+linux-wireless@lfdr.de>; Sun,  3 May 2026 17:54:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11FF6383C85;
	Sun,  3 May 2026 17:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fzw+uEFQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F832F5321
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 17:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777830851; cv=none; b=ZR4TPeT+TSOvchVhU4gBFeimDcSt+/+K7E8/QtsxKAr3veZe8ALDiHnIsWJbKQnAWB8WSNwDM00K9w5oU7rTaX9bda5pEs9YWXxxIq2fy/9E9zVfdk8lw+6q5PbSbGwaEqy5LdIMwHlRb8qdP1kJTtuPQs/AUTVaPAjNbIxXZ9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777830851; c=relaxed/simple;
	bh=vZix6njdv2p1CVHPQk3N5+z8QTc46xF0Umj6dJoNSss=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pLhXPGMoJvftAbjP6tFRuB90sYJn4QRfPjZUt8tWI23m4WQR6AFrMKdMlKE8UvHv/bp4JQa9Ia/1OloqDO3BPf39eA58ctFXoGXpkQwvDiAyoK0aTmfjDjF1q7/s+InaVOrADfUR2n330pPgkCfKYXJAKo4BhjOK1HSFdEStHrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fzw+uEFQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C791BC2BD00
	for <linux-wireless@vger.kernel.org>; Sun,  3 May 2026 17:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777830850;
	bh=vZix6njdv2p1CVHPQk3N5+z8QTc46xF0Umj6dJoNSss=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=fzw+uEFQ1htYzOl+xFJqUU+e7m4wKFi685C/CP8i1VOOvuHtLSJP+gW2oAn56LhFE
	 Hj6oAPcSoEty8SFElbgQhmfO0Gpkja/vOoqkQSBVBfSQ8r/JnwW6qWXTiclf+fMbuo
	 IqoXiRG+V/Nln17tZ/g9SHdwwmIcBXQahmHH3n3u2HDyCbdF8z1VYHY8S8PhVwR6yn
	 xNQZmayPAw4tk7idT/+b+O0UItKuH3AXnbyXFPeH+VSBg3dvHEWTH0Bmq8K8wBU+QJ
	 BNJ2Ufhw7VmHeS5Qo41wPK7rXmlNL6n0zzMIXynggnKT2ngA9WRnJ5ZIlgUQUH+oSk
	 qjXAeptDzK32w==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-3938cc204a7so7913261fa.1
        for <linux-wireless@vger.kernel.org>; Sun, 03 May 2026 10:54:10 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9H/e2bGvB1sI6fWo8yXqp+xQL0r45pVGm6Ier40S1gQtb+kBYdJ2pRp2D/hfKT0Cz2z7kHDS+hGI+uSlZ3GA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0oHPJRtp7EnKo0VA6xMOxn4wxLVJ+GoOvZ4RNwSo5aTEtZu/O
	4a8no46OQmq/v/HRmnUmfSA1e69qaHQm8TqWpk4fKZAPRaF2BHpI907B8dbA+iACRnBZXgd3NMT
	AqYPjug5lRWy98mQ6NGircJ4OwhdVpI8=
X-Received: by 2002:a2e:7c0b:0:b0:393:71d3:d019 with SMTP id
 38308e7fff4ca-393784e5ffbmr21655141fa.15.1777830848881; Sun, 03 May 2026
 10:54:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260503-mt7925-tdls-fixes-v1-0-dde847e21081@gmail.com> <20260503-mt7925-tdls-fixes-v1-1-dde847e21081@gmail.com>
In-Reply-To: <20260503-mt7925-tdls-fixes-v1-1-dde847e21081@gmail.com>
From: Sean Wang <sean.wang@kernel.org>
Date: Sun, 3 May 2026 12:53:57 -0500
X-Gmail-Original-Message-ID: <CAGp9LzogKfGovfDw+=m4BkqWAakFTStXH20cQ_FA_5-zo+rmGA@mail.gmail.com>
X-Gm-Features: AVHnY4KyXQ7oHCi5bs4lLYBGHsaGNKAAiWN14GcaixGFGQwp3VhrQVd9985J61o
Message-ID: <CAGp9LzogKfGovfDw+=m4BkqWAakFTStXH20cQ_FA_5-zo+rmGA@mail.gmail.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt792x: disable HW TX/RX encap offload to
 fix TDLS direct-link
To: ElXreno <elxreno@gmail.com>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
	Soul Huang <Soul.Huang@mediatek.com>, Ming Yen Hsieh <mingyen.hsieh@mediatek.com>, 
	Deren Wu <deren.wu@mediatek.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-mediatek@lists.infradead.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0E8644B6D8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35798-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

Hi ElXreno,

On Sat, May 2, 2026 at 8:40=E2=80=AFPM ElXreno <elxreno@gmail.com> wrote:
>
> On MediaTek MT7925 (Connac3), QoS Data frames whose destination WCID
> is a TDLS direct-link peer are silently dropped after submission to
> firmware via the HW_80211_ENCAP TX path. The driver sees submit and
> complete counts match (firmware reports success on TX queue
> submission), but the frames never reach the PHY. iw counters show
> tx_packets growing, tx_failed =3D 0, tx_retries low; on the air,
> nothing.
>
> This breaks TDLS direct-link as soon as a peer auto-initiates one
> (Samsung phones do this aggressively when both peers share a BSS and
> traffic exceeds a threshold). Pattern is:
>
>   1. Any sustained direct traffic between two STAs sharing the BSS
>      reaches the auto-TDLS threshold within ~1 s.
>   2. Peer initiates TDLS; mac80211 routes data frames to the TDLS-peer
>      WCID and the AP stops forwarding peer-to-peer traffic per the
>      802.11z spec.
>   3. Direct-link frames are accepted by firmware, completed in the TX
>      descriptor pool, but never PHY-transmitted.
>   4. TCP collapses; the peer eventually tears down the TDLS link with
>      reason WLAN_REASON_TDLS_TEARDOWN_UNSPECIFIED. Cycle repeats.
>
> Effective TCP throughput drops from ~300 Mbit/s (AP route) to ~6
> Mbit/s with TDLS active.
>
> Verified on mt7925e (PCIe) at 5 GHz HE NSS 2 MCS 11 80 MHz and at
> 2.4 GHz 802.11n HT NSS 2 MCS 15. With this patch, TDLS direct link
> sustains ~750 Mbit/s and ~130 Mbit/s respectively.
>
> mt76 advertises WIPHY_FLAG_SUPPORTS_TDLS via the shared
> mt76_register_phy_helper() but does not provide TDLS-aware
> firmware-facing peer setup: no CONNECTION_TDLS constant in
> mt76_connac_mcu.h, no STA_REC_TDLS TLV, no TDLS bit in
> mt76_wcid_flags, and no TDLS-specific code in
> mt7925_mac_write_txwi_8023(). TDLS peers are registered as
> CONNECTION_INFRA_STA with peer_addr set to the peer's MAC and
> nothing else. The proprietary out-of-tree MediaTek driver carries an
> explicit cfg80211_tdls.c (PTK/TK install paths, etc.) with no
> in-tree equivalent. Whether the underlying gap is in the firmware
> HW_ENCAP path or in mt76's missing TDLS-aware setup is unclear from
> the kernel side; the software-encap path sidesteps it either way.
>
> Work around the issue by not advertising SUPPORTS_TX_ENCAP_OFFLOAD
> and SUPPORTS_RX_DECAP_OFFLOAD in mt792x_init_wiphy(). mac80211 then
> takes the software 802.11 encap path, which submits already-formed
> 802.11 frames via a different firmware path that handles all WCIDs
> correctly, including TDLS peers.
>
> mt792x_init_wiphy() is shared with the Connac2 family (mt7921/22/20/02),
> which uses the same firmware HW_ENCAP path; the disable is applied
> globally to cover the likely-affected chips. If Connac2 is later
> confirmed unaffected, the disable can be narrowed with is_mt7925().
>
> Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
> Cc: stable@vger.kernel.org
> Signed-off-by: ElXreno <elxreno@gmail.com>
> Assisted-by: Claude:claude-opus-4-7 bpftrace
> ---
>  drivers/net/wireless/mediatek/mt76/mt792x_core.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mt792x_core.c b/drivers/n=
et/wireless/mediatek/mt76/mt792x_core.c
> index 152cfcca2f90..f9610c6c1597 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt792x_core.c
> @@ -681,8 +681,14 @@ int mt792x_init_wiphy(struct ieee80211_hw *hw)
>
>         ieee80211_hw_set(hw, SINGLE_SCAN_ON_ALL_BANDS);
>         ieee80211_hw_set(hw, HAS_RATE_CONTROL);
> -       ieee80211_hw_set(hw, SUPPORTS_TX_ENCAP_OFFLOAD);
> -       ieee80211_hw_set(hw, SUPPORTS_RX_DECAP_OFFLOAD);
> +       /* HW TX/RX 802.11 encap offload is intentionally NOT advertised:
> +        * the firmware HW_80211_ENCAP path silently drops QoS Data frame=
s
> +        * whose destination WCID is a TDLS direct-link peer, breaking TD=
LS
> +        * data flow. The mac80211 software encap path submits already-fo=
rmed
> +        * 802.11 frames, which the firmware handles correctly for all WC=
IDs.
> +        * Re-add SUPPORTS_TX_ENCAP_OFFLOAD / SUPPORTS_RX_DECAP_OFFLOAD h=
ere
> +        * once the firmware HW_ENCAP path is fixed.
> +        */

I do not think disabling TX/RX encap offload globally in
mt792x_init_wiphy() is the right fix.

The reported failure is specific to TDLS direct-link peers, while this
change affects all normal STA/AP/P2P data paths and all mt792x chips,
including mt7925/mt7921/22/20/02. This is too broad for a TDLS-specific iss=
ue.

The commit message already points out that mt76 lacks TDLS-aware
firmware-facing peer setup, and also mentions that the proprietary
out-of-tree MediaTek driver has an explicit cfg80211_tdls.c
implementation. If that driver supports TDLS on top of the firmware HW
encap model, I think we should try to align the in-tree driver with that
design by adding the missing TDLS-aware firmware-facing peer setup,
instead of disabling HW encap globally.

In particular, I would prefer to first check whether adding
CONNECTION_TDLS / proper TDLS peer setup on top of the current code is
enough to fix the issue.

Please avoid removing SUPPORTS_TX_ENCAP_OFFLOAD and
SUPPORTS_RX_DECAP_OFFLOAD globally from mt792x_init_wiphy().

>         ieee80211_hw_set(hw, WANT_MONITOR_VIF);
>         ieee80211_hw_set(hw, SUPPORTS_PS);
>         ieee80211_hw_set(hw, SUPPORTS_DYNAMIC_PS);
>
> --
> 2.53.0
>
>

