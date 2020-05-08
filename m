Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19F291CB517
	for <lists+linux-wireless@lfdr.de>; Fri,  8 May 2020 18:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726771AbgEHQle (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 8 May 2020 12:41:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726750AbgEHQle (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 8 May 2020 12:41:34 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D995C061A0C
        for <linux-wireless@vger.kernel.org>; Fri,  8 May 2020 09:41:34 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id z25so1920047otq.13
        for <linux-wireless@vger.kernel.org>; Fri, 08 May 2020 09:41:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g+QntSX6UHjdN+6HDZlsPfTgHd6g+I/Q6VEHy2iKxho=;
        b=EFF/pX2SoY7VitBlZnYbYKtaMsSgexrgVH9JZHd1GuJOm3R9OaaMouXrnaFhDDSnH6
         SowrtOpTEFYWyyFrBMIbb/K0l1cB2DE4g+9AY0FOsbcxC54cvlaywtPKDJxaWTgw5qk6
         JdRe74FpgNXT/XuF8j6s1zW2T+U5cwBuNO5L+wneQCTq2q/2GZTMvIQDajvGTsZ542Hz
         tpE2poX2miWdW8Cp3uND4eTaBaMaFwPHXulE2iXbxyYmzUSx89L6UCkP+3Ie6odTb2KG
         dMb4cx9UpUuvawkURZcgWlYhW+oPPZxmx2v5Iz8s5ZMdGrQV2+ZUhlwBG91xleq8jaIg
         Y5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g+QntSX6UHjdN+6HDZlsPfTgHd6g+I/Q6VEHy2iKxho=;
        b=gq0oh/1XU7QhwamJDMjmG6a5pvTon3QOm9mlvsoGcrS4V0lot/EdAfzE9mwu3qdGfh
         UoJ7qfSsDbdQwL+/XRZlONsowqlV3HTkKapVizkvu2iLlTqeCllbpF4vLvSD6Y2gRn2+
         vOtQ7owjavOgCXFan4OghR2gTaeB2lnSsgZ6RyTVmvTMTJnvbhGu3c+n+cLBztQGL5z/
         OTgIp8VAxI7SeyIo1WdmACTWKiWu7zoUHUFkIlPDSZrL4qeqIZcgxF3QqW1AvDlXl9lq
         +V1xI9sR19RV9wf00p6vnH/2swnWjxmJ370HQsuCCWNzO62t9MJqtJjH6swdFDi9JecR
         8ffw==
X-Gm-Message-State: AGi0PuZXaXprSrzV/bPqMQM7M5gYFayJUqwg94unImzGq0Z3mtVa4Jph
        acmbq6Go1hbUKRkjH632omx4M6OBvuo6v/hrD1A=
X-Google-Smtp-Source: APiQypI66m2svur0AQ9jBEzHdPSlugs2zRp1NmX9BrN1Qb4nzW4QiyhD3fS10yKm5jRYKV8KFtItZNOIu6e8/obYdDY=
X-Received: by 2002:a9d:29:: with SMTP id 38mr2934329ota.322.1588956092767;
 Fri, 08 May 2020 09:41:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200508140802.558267-1-luca@coelho.fi> <iwlwifi.20200508170402.c3e50c36c628.I991bfa662c0ef35de5be9eaf5b78ef190b67cb56@changeid>
In-Reply-To: <iwlwifi.20200508170402.c3e50c36c628.I991bfa662c0ef35de5be9eaf5b78ef190b67cb56@changeid>
From:   =?UTF-8?B?0JrQuNGA0LjQu9C7INCb0YPQutC+0L3QuNC9?= 
        <klukonin@gmail.com>
Date:   Fri, 8 May 2020 21:41:06 +0500
Message-ID: <CALYz8ypzgHqn+WY8KG-isYXJfymy4Jh7CSEXsg5KdiGEm+EAVQ@mail.gmail.com>
Subject: Re: [PATCH 01/11] iwlwifi: set NO_HE if the regulatory domain forbids it
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Does it mean that wireless-regdb is not needed anymore and any vendor
can configure wireless stack from it's proprietary firmware?


Best Regards,
Lukonin Kirill

Best Regards,
Lukonin Kirill


=D0=BF=D1=82, 8 =D0=BC=D0=B0=D1=8F 2020 =D0=B3. =D0=B2 19:12, Luca Coelho <=
luca@coelho.fi>:
>
> From: Haim Dreyfuss <haim.dreyfuss@intel.com>
>
> If the firmware's regulatory domain forbids HE operation, set it
> in the cfg80211 regdomain.
>
> Signed-off-by: Haim Dreyfuss <haim.dreyfuss@intel.com>
> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
> ---
>  drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c b/drivers=
/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> index d91a8e8349e6..ee410417761d 100644
> --- a/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> +++ b/drivers/net/wireless/intel/iwlwifi/iwl-nvm-parse.c
> @@ -240,6 +240,7 @@ enum iwl_nvm_channel_flags {
>   * @REG_CAPA_40MHZ_FORBIDDEN: 11n channel with a width of 40Mhz is forbi=
dden
>   *     for this regulatory domain (valid only in 5Ghz).
>   * @REG_CAPA_DC_HIGH_ENABLED: DC HIGH allowed.
> + * @REG_CAPA_11AX_DISABLED: 11ax is forbidden for this regulatory domain=
.
>   */
>  enum iwl_reg_capa_flags {
>         REG_CAPA_BF_CCD_LOW_BAND        =3D BIT(0),
> @@ -250,6 +251,7 @@ enum iwl_reg_capa_flags {
>         REG_CAPA_MCS_9_ALLOWED          =3D BIT(5),
>         REG_CAPA_40MHZ_FORBIDDEN        =3D BIT(7),
>         REG_CAPA_DC_HIGH_ENABLED        =3D BIT(9),
> +       REG_CAPA_11AX_DISABLED          =3D BIT(10),
>  };
>
>  static inline void iwl_nvm_print_channel_flags(struct device *dev, u32 l=
evel,
> @@ -1115,6 +1117,9 @@ static u32 iwl_nvm_get_regdom_bw_flags(const u16 *n=
vm_chan,
>                         flags |=3D NL80211_RRF_NO_160MHZ;
>         }
>
> +       if (cap_flags & REG_CAPA_11AX_DISABLED)
> +               flags |=3D NL80211_RRF_NO_HE;
> +
>         return flags;
>  }
>
> --
> 2.26.2
>
