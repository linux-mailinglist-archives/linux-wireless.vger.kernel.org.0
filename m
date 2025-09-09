Return-Path: <linux-wireless+bounces-27193-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EF93DB507F6
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 23:17:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E84ED5E44B2
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Sep 2025 21:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A970250BEC;
	Tue,  9 Sep 2025 21:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OXU+R5JK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FBCB31D389
	for <linux-wireless@vger.kernel.org>; Tue,  9 Sep 2025 21:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757452655; cv=none; b=QXgPfhAy9fkkBfMn4vgO6+QsV/jYMWpo05cis3qAYmkXPxwAp/xxNOo83AhOYpcCEhcWATuCyGnPbfSw5pz0ysL2nUnwsXLtg7JxM+SCpgjYNoUTwsOzuq2PS+94COo24hHWjJWBFb8682P/fWV/U9s83L4iy2ZZv9WgjSNkT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757452655; c=relaxed/simple;
	bh=HqYbrFUFeibsZnZKsMf9FgZ9s/maKdF08mAaV92ILmY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=bt6aCUQibOxMyxcDo6JFZRC78a5I+y2efgRUSJh/yUMtkX7BpDUkcw10ag3+XW5psvSeTN/aAtFFQYNPAiDK/MPccDLWTumQn+F9V7r3CPFgYmshsrwfFGNwf1U0qXOYdnemOJ59RQEZ5638vxBRJSfT/jMjeagOzV3FC6GQJo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OXU+R5JK; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-45df7cb7f6bso611085e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 09 Sep 2025 14:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1757452652; x=1758057452; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0N1NCIdRK4PVMotSCtjNyyl/LP3BVDUFyoGUcQcV1nU=;
        b=OXU+R5JKJCIPIgq3vU6oaf28l+4Q8BrC2mqKiprF2BIPhsStdF+nyMi/OstgDrjrhJ
         Mn27jczsEfdUqpTtXRlljAE4ShnSfETnFiXjAGGeUt0Z27ts5QrzeVbFkHt2IcVna14b
         fcmtV6alWLAGsQnYZSHVud5IYmU8Ul0G2ED91VNmjXZB1YcNHQRPaQ9JSLa8rF5uZ7Jv
         Dmc3abjLtBNnbFSIgxTSJT+bXcykoIfJ29Qu8DmSmEl1nqXuIfRtpatFN9hTiAeVOj5+
         6o7fb24yJHTZh51UYPPTiriW7PrkAUnHOolFIQPUDMryp7zrIQoVFUWjxXjdYUV5Zjc0
         l/1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757452652; x=1758057452;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0N1NCIdRK4PVMotSCtjNyyl/LP3BVDUFyoGUcQcV1nU=;
        b=FOCUhEkz0ZMgfYcmwcD6AlXAlTmrByLL4Z5hykjL1wxTqH3JtuxJsfLSGaDz1qtev6
         Uj+L4VbfXx0R6oioMR5r8Eco+eL6MS1r7BRT2fb8RrkFs5pItlGcMJ2MGKWLtepKK+GA
         9QsleJHteXODCc5wy1IO96+3gv6ZHZ+Kt+GGcDlzyATga08WtnH7wHONm6e0IvPt8W6q
         G/sFPvhOwaECI7n/Steozz5O939+eA5WEZBR/bzKRdGdn2PPRe5q0Gkbf6Ki2+canvc7
         nqLMdaJ/Pv7L1qUwLDnJCrYKywU61EJhJzE2EVxV9hyROhgeRbeTTtmzNI+ad3A/rSX4
         Hl3w==
X-Forwarded-Encrypted: i=1; AJvYcCVDu933n7LbDEAU1eQ+8Q3Hn8S6IiPGrBTyegF9hpwUSucQcF15hgJLXIwWve1fCigLB0QU24abgumplkKrTA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwzSfu/CtQWmt4Dc15gDanC1+1FdKN/YSUjMSlSpemaX2g6LjS1
	H9r/Tsy1MziNq2YIilx1VP7PxK8sQC7xv+Zf5g03QF3FDhzqhEjozlNYUh8pCJAgjNI=
X-Gm-Gg: ASbGncu7j2XWzygGTs96SsTsmqj2yvQb0bsEDwIc4vEbe5BLOlM/aLc6emosLw6liYX
	SqRRIdnS805uJGHN1bpZA3EzLG9kfzHuWfd2ATQInYSB3TqGjPw7jtclPUlBsa92+qRrxEKqn4w
	MG7pAl6uKyjNc14yFL0OaEW2LUH76czQftpVhVpTRbTBJBoXpevLbEgiU2/pVPnWH1/u/RCl12j
	XC9Om+4LUQe7OkFyRjrTbscUV2zD9+0Zq4OC5q+iqI6ISBtEfSjdWWp6bS2plYSx0J4s89nsTJn
	VxyL+XbDDQLGMRQkRqxJRgtZ59ar74fJY++CzrrWtx7iQZzd5yKfbOKB+5nWuSbTb2B83Lct+DR
	47LumIyWZ5UcwoFhS1iMJcdYMxNM=
X-Google-Smtp-Source: AGHT+IFfPqt52sJ2bwTn8g9bFD7BIz/dicnzT8ODVk1qTowYr0C9FHz83+RjHbYNDSjICY3IUGu4cA==
X-Received: by 2002:a05:600c:8010:b0:45b:9912:9f1e with SMTP id 5b1f17b1804b1-45df0e619afmr31135875e9.3.1757452652352;
        Tue, 09 Sep 2025 14:17:32 -0700 (PDT)
Received: from localhost ([2a02:c7c:7259:a00:c21d:84a2:1410:7b31])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45df81cbd13sm1712005e9.4.2025.09.09.14.17.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Sep 2025 14:17:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 09 Sep 2025 22:17:31 +0100
Message-Id: <DCOKYY8GG7IP.1ABNFNTEIME4F@linaro.org>
Subject: Re: [PATCH ath-current v2] wifi: ath10k: Fix connection after GTK
 rekeying
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Loic Poulain" <loic.poulain@oss.qualcomm.com>, <jjohnson@kernel.org>
Cc: <stable@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath10k@lists.infradead.org>, <johannes@sipsolutions.net>
X-Mailer: aerc 0.20.0
References: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>
In-Reply-To: <20250902143225.837487-1-loic.poulain@oss.qualcomm.com>

(add stable into c/c)


On Tue Sep 2, 2025 at 3:32 PM BST, Loic Poulain wrote:
> It appears that not all hardware/firmware implementations support
> group key deletion correctly, which can lead to connection hangs
> and deauthentication following GTK rekeying (delete and install).
>
> To avoid this issue, instead of attempting to delete the key using
> the special WMI_CIPHER_NONE value, we now replace the key with an
> invalid (random) value.
>
> This behavior has been observed with WCN39xx chipsets.
>
> Tested-on: WCN3990 hw1.0 WLAN.HL.3.3.7.c2-00931-QCAHLSWMTPLZ-1
> Reported-by: "Alexey Klimov" <alexey.klimov@linaro.org>
> Closes: https://lore.kernel.org/all/DAWJQ2NIKY28.1XOG35E4A682G@linaro.org
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>

The fix works great on RB1 board. Thank you.

Tested-by: Alexey Klimov <alexey.klimov@linaro.org> # QRB2210 RB1

Difficult to say when this issue appeared initially. I'd say that around 6.=
6
it worked fine probably.
But latest few kernel releases like 6.16, 6.15, 6.14 definetely had this is=
sue.
Maybe makes sense to add something like that:

Cc: stable@vger.kernel.org # v6.14

> ---
>  v2: use random value instead of predictable zero value for key
>      Add Tested-on tag
>
>  drivers/net/wireless/ath/ath10k/mac.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/net/wireless/ath/ath10k/mac.c b/drivers/net/wireless=
/ath/ath10k/mac.c
> index 24dd794e31ea..154ac7a70982 100644
> --- a/drivers/net/wireless/ath/ath10k/mac.c
> +++ b/drivers/net/wireless/ath/ath10k/mac.c
> @@ -16,6 +16,7 @@
>  #include <linux/acpi.h>
>  #include <linux/of.h>
>  #include <linux/bitfield.h>
> +#include <linux/random.h>
> =20
>  #include "hif.h"
>  #include "core.h"
> @@ -290,8 +291,15 @@ static int ath10k_send_key(struct ath10k_vif *arvif,
>  		key->flags |=3D IEEE80211_KEY_FLAG_GENERATE_IV;
> =20
>  	if (cmd =3D=3D DISABLE_KEY) {
> -		arg.key_cipher =3D ar->wmi_key_cipher[WMI_CIPHER_NONE];
> -		arg.key_data =3D NULL;
> +		if (flags & WMI_KEY_GROUP) {
> +			/* Not all hardware handles group-key deletion operation
> +			 * correctly. Replace the key with a junk value to invalidate it.
> +			 */
> +			get_random_bytes(key->key, key->keylen);
> +		} else {
> +			arg.key_cipher =3D ar->wmi_key_cipher[WMI_CIPHER_NONE];
> +			arg.key_data =3D NULL;
> +		}
>  	}
> =20
>  	return ath10k_wmi_vdev_install_key(arvif->ar, &arg);


Best regards,
Alexey

