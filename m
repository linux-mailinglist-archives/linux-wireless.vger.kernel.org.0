Return-Path: <linux-wireless+bounces-31412-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OAckKcpcfWnKRgIAu9opvQ
	(envelope-from <linux-wireless+bounces-31412-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 02:37:14 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C38BC008C
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 02:37:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A67B43010515
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Jan 2026 01:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 661762FD1DB;
	Sat, 31 Jan 2026 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgXpE0tD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AB92BDC27
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 01:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769823431; cv=none; b=gklCkidgBgU2tOZggwoVYRI8AoD+6wOA2NsWq1HWAJ/LvNmJrgtkLjm6EMumhJp5LUIDuxjAOAHjXlJ+ZJgYnGQbDHSg3stOzgF4tHCw2jkc36OM3WhgPu8m+As270b34m7nukWpfS59pNKQiNR1osYwOsfK1udWgIOHe+A84SE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769823431; c=relaxed/simple;
	bh=HSlwIJ3DA03/OunBfURR+gTgDH9OrO+A2nv+pjkXXjw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jdjlu0+BpBCAoM5kWNlRmo/7ExriVDCUQzWvrZ5kTYJTU8kI0cDKNldib9wRRzMotYHpOzwG1RBEsID8c4HA3xzh1EEy28Yw4ad+SppwbmK0Nydvpsq03GzszUr6fZtpjdT18CwNezo205KThxr1Agig2A9DTlMxASlimQxOVxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgXpE0tD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E7DEC19421
	for <linux-wireless@vger.kernel.org>; Sat, 31 Jan 2026 01:37:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769823431;
	bh=HSlwIJ3DA03/OunBfURR+gTgDH9OrO+A2nv+pjkXXjw=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=QgXpE0tDl3vo6ylg8njiRaJhA142z6t9oj9LisXrIMOCApL9oRxp6dO8R+a56W+iy
	 090+Utx6lu425HbkFoLbfPXsizeAl5hU4rWVqA6FBlTufiymgDPsVcboGy4A9KV8U5
	 DgCru4xNydtjMLpdvNYv3PQmzrm6LygJnxdz53Y6Icu65seR3mUipjgJ5pXLf0xH5A
	 +TdshQjXiJd4NNMY+D+ZToG2mJxW7D7iA26BZ1wLJsnIvrOocufWm7kDl2ognpbGS7
	 Ab0xs+6OGeUc/5D0yoI4VVqlWy2XnGpIpM+W3mi2JUamOMnssMv6Envx6VFz/59xa0
	 b8hcbXkhqAJ/A==
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59b834e3d64so2975185e87.2
        for <linux-wireless@vger.kernel.org>; Fri, 30 Jan 2026 17:37:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUq5d6Sc8yDTjzlY/pEB9HdzSslLdTbY9jnQTNIOSq13gp3TORU7c4/2zzUUVQHD2hzJTBhWnTS/95Zeal1yA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzeKVeNX98TTYrWwA5kby95EKkA/Sa9ac3LqFlQwYzJgqnK2T3V
	i0p0vd2CKz8dUGBoPV0hpVKaO30G8WsK7VynlDX8miSmFqrvk2dGoMwA8WYhqtQkgdG/7oRu+tT
	jk0AHjHhUFQLhlqzUVSaEa/pmNxwZy3I=
X-Received: by 2002:a05:6512:ad4:b0:59b:70e7:4128 with SMTP id
 2adb3069b0e04-59e16463c5emr1561236e87.53.1769823429264; Fri, 30 Jan 2026
 17:37:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260130032517.173590-1-n7l8m4@u.northwestern.edu>
In-Reply-To: <20260130032517.173590-1-n7l8m4@u.northwestern.edu>
From: Sean Wang <sean.wang@kernel.org>
Date: Fri, 30 Jan 2026 19:36:56 -0600
X-Gmail-Original-Message-ID: <CAGp9LzqQ45LAeeG1Cijs1QmtzBjOmML_qY=9Y5zH8tYmZeQWZQ@mail.gmail.com>
X-Gm-Features: AZwV_Qgzlc9REroD0uijyrgcGZUw6qt5vKeV6p_1BhQT_C5t6Fi3nVhTvV39E4c
Message-ID: <CAGp9LzqQ45LAeeG1Cijs1QmtzBjOmML_qY=9Y5zH8tYmZeQWZQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: mt76: add missing lock protection in mt76_sta_state
 for sta_event callback
To: Ziyi Guo <n7l8m4@u.northwestern.edu>
Cc: Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>, 
	Shayne Chen <shayne.chen@mediatek.com>, Sean Wang <sean.wang@mediatek.com>, 
	Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31412-lists,linux-wireless=lfdr.de];
	FREEMAIL_CC(0.00)[nbd.name,kernel.org,mediatek.com,gmail.com,collabora.com,vger.kernel.org,lists.infradead.org];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sean.wang@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,northwestern.edu:email]
X-Rspamd-Queue-Id: 0C38BC008C
X-Rspamd-Action: no action

On Thu, Jan 29, 2026 at 9:25=E2=80=AFPM Ziyi Guo <n7l8m4@u.northwestern.edu=
> wrote:
>
> mt76_sta_state() calls the sta_event callback without holding dev->mutex.
> However, mt7915_mac_sta_event() (MT7915 implementation of this callback)
> calls mt7915_mac_twt_teardown_flow() which has
> lockdep_assert_held(&dev->mt76.mutex) indicating that callers must
> hold this lock.
>
> The locking pattern in mt76_sta_state() is inconsistent:
> - mt76_sta_add() acquires dev->mutex before calling dev->drv->sta_add
> - mt76_sta_remove() acquires dev->mutex before calling __mt76_sta_remove
> - But sta_event callback is called without acquiring the lock
>
> Add mutex_lock()/mutex_unlock() around the sta_event callback invocation
> to fix the missing lock protection and maintain consistency with the
> existing locking pattern.
>

The mt7921 / mt7925 .sta_event callback already holds the lock; this
patch would cause a deadlock. Suggest adding the implementation to
MT7915.

> Signed-off-by: Ziyi Guo <n7l8m4@u.northwestern.edu>
> ---
>  drivers/net/wireless/mediatek/mt76/mac80211.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/=
wireless/mediatek/mt76/mac80211.c
> index 75772979f438..468bc176bacb 100644
> --- a/drivers/net/wireless/mediatek/mt76/mac80211.c
> +++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
> @@ -1640,6 +1640,7 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct =
ieee80211_vif *vif,
>         struct mt76_phy *phy =3D hw->priv;
>         struct mt76_dev *dev =3D phy->dev;
>         enum mt76_sta_event ev;
> +       int ret;
>
>         phy =3D mt76_vif_phy(hw, vif);
>         if (!phy)
> @@ -1668,7 +1669,11 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct=
 ieee80211_vif *vif,
>         else
>                 return 0;
>
> -       return dev->drv->sta_event(dev, vif, sta, ev);
> +       mutex_lock(&dev->mutex);
> +       ret =3D dev->drv->sta_event(dev, vif, sta, ev);
> +       mutex_unlock(&dev->mutex);
> +
> +       return ret;
>  }
>  EXPORT_SYMBOL_GPL(mt76_sta_state);
>
> --
> 2.34.1
>
>

