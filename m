Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 127187EED9B
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 09:37:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230376AbjKQIhk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Nov 2023 03:37:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjKQIhj (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Nov 2023 03:37:39 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FACA7
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 00:37:36 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso2495384a12.1
        for <linux-wireless@vger.kernel.org>; Fri, 17 Nov 2023 00:37:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1700210255; x=1700815055; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XxmgjLg9qqtxBzFlC8UChJ5NYnpOfd/DhQ8GlEoFRBM=;
        b=PcrdIpQpnVeE8RbxH+i+dcd7uEP/ARn8Nf5EzfwtImDi4dDVqMYdNHvJteU4Y//1to
         4h93nirhuPuS99KmvBGEOOu7GafLlf+8PRav/+in7Fp+czXyupRGubnydJC4xWWZjhav
         cjnQrcur41Ew3EjaWL3SF7JUERTL3tQ0I1Zqk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700210255; x=1700815055;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XxmgjLg9qqtxBzFlC8UChJ5NYnpOfd/DhQ8GlEoFRBM=;
        b=Wn823L/sZJFRstaygP3mOhdm3qnP4MHpoUwqXjja5l3DHeSptWDvCQRD6Mut+5J9Y8
         tqoSF7cgZkR7r0sYwEm9u4fJRQ1KSArWckpVrC/OvTLeIVrZ/CJrnKMTJygm6ai83bkN
         RNE6XcMKaZcMIAecYjMDvLEiHxLnV/cluDgBPgQuCsugaLy0oPF5NOWn9bYSkqADh4ho
         0r8nwtl2EPeKNMm6+V2iSa8WJPgzCVAB7DAdxpNhUsic1GoJ8LwxnEVl2eEtzMe2K07x
         SkZpnHBuPbul6rQVqQqUrbOAJ700/buMnKGVg6nz98Jv8Y6uadblaOfU6Vc74JXjDzsR
         /Lng==
X-Gm-Message-State: AOJu0Yy8Bdhfc0qwW0s5hIOMLw5baMz1C3tupPxM2W6+GTmR1lf4jtkF
        sW26rr612NfgZIF/Lp/81Y2nDHvaR07ZpYNbl0pmrg==
X-Google-Smtp-Source: AGHT+IH8RT8Voc+RS40SmAGz+Q6ss85XTKSjnKu6C40I+6N7MsTfk8YkeFyOlTWFJ7geIift2pTC3LXf6wtXC1c6p7I=
X-Received: by 2002:a05:6402:1001:b0:533:c75a:6f6 with SMTP id
 c1-20020a056402100100b00533c75a06f6mr14156394edu.12.1700210254385; Fri, 17
 Nov 2023 00:37:34 -0800 (PST)
MIME-Version: 1.0
References: <ff0778a86574b552769027496f12596e2e627931.1699530774.git.vinayak.yadawad@broadcom.com>
In-Reply-To: <ff0778a86574b552769027496f12596e2e627931.1699530774.git.vinayak.yadawad@broadcom.com>
From:   Jithu Jance <jithu.jance@broadcom.com>
Date:   Fri, 17 Nov 2023 14:07:22 +0530
Message-ID: <CA+gyVQ1iU3OM+kpBGSGp4hCexqkOCR8Gd44w+vV_eVnm7NffkA@mail.gmail.com>
Subject: Re: [PATCH v3 1/1] wifi: nl80211: Extend del pmksa support for SAE
 and OWE security
To:     Vinayak Yadawad <vinayak.yadawad@broadcom.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004c2adf060a550c3f"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000004c2adf060a550c3f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Johannes,

Could you please let us know whether this patch is fine. If fine, we
shall go ahead and submit the patch for wpa_supplicant as well. This
patch is useful for allowing the user space to flush PMKs generated at
firmware for the SAE/OWE offloads when a user changes
credential/removes the connection profile.

Thanks,

Jithu Jance



Jithu Jance


On Thu, Nov 9, 2023 at 6:00=E2=80=AFPM Vinayak Yadawad
<vinayak.yadawad@broadcom.com> wrote:
>
> Current handling of del pmksa with SSID is limited to FILS
> security. In the current change the del pmksa support is extended
> to SAE/OWE security offloads as well. For OWE/SAE offloads, the
> PMK is generated and cached at driver/FW, so user app needs the
> capability to request cache deletion based on SSID for drivers
> supporting SAE/OWE offload.
>
> Signed-off-by: Vinayak Yadawad <vinayak.yadawad@broadcom.com>
> ---
> v1->v2: Addressed review comments for indentation
> v2->v3: Addressed review comments for version update in header
> ---
>  net/wireless/nl80211.c | 27 ++++++++++++++++++++-------
>  1 file changed, 20 insertions(+), 7 deletions(-)
>
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 569234bc2be6..8dc1c800f171 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -12183,24 +12183,37 @@ static int nl80211_setdel_pmksa(struct sk_buff =
*skb, struct genl_info *info)
>
>         memset(&pmksa, 0, sizeof(struct cfg80211_pmksa));
>
> -       if (!info->attrs[NL80211_ATTR_PMKID])
> +       if ((info->genlhdr->cmd =3D=3D NL80211_CMD_SET_PMKSA) &&
> +           (!info->attrs[NL80211_ATTR_PMKID]))
>                 return -EINVAL;
>
> -       pmksa.pmkid =3D nla_data(info->attrs[NL80211_ATTR_PMKID]);
> +       if (info->attrs[NL80211_ATTR_PMKID])
> +               pmksa.pmkid =3D nla_data(info->attrs[NL80211_ATTR_PMKID])=
;
>
>         if (info->attrs[NL80211_ATTR_MAC]) {
>                 pmksa.bssid =3D nla_data(info->attrs[NL80211_ATTR_MAC]);
> -       } else if (info->attrs[NL80211_ATTR_SSID] &&
> -                  info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
> -                  (info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMKSA ||
> +       } else if (info->attrs[NL80211_ATTR_SSID]) {
> +               /* SSID based pmksa flush suppported only for FILS,
> +                * OWE/SAE OFFLOAD cases
> +                */
> +               if (info->attrs[NL80211_ATTR_FILS_CACHE_ID] &&
> +                   (info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMKSA ||
>                     info->attrs[NL80211_ATTR_PMK])) {
> +                       pmksa.cache_id =3D
> +                               nla_data(info->attrs[NL80211_ATTR_FILS_CA=
CHE_ID]);
> +               } else if ((info->genlhdr->cmd =3D=3D NL80211_CMD_DEL_PMK=
SA) &&
> +                   (!wiphy_ext_feature_isset(
> +                   &rdev->wiphy, NL80211_EXT_FEATURE_SAE_OFFLOAD) &&
> +                   (!wiphy_ext_feature_isset(
> +                   &rdev->wiphy,NL80211_EXT_FEATURE_OWE_OFFLOAD)))){
> +                       return -EINVAL;
> +               }
>                 pmksa.ssid =3D nla_data(info->attrs[NL80211_ATTR_SSID]);
>                 pmksa.ssid_len =3D nla_len(info->attrs[NL80211_ATTR_SSID]=
);
> -               pmksa.cache_id =3D
> -                       nla_data(info->attrs[NL80211_ATTR_FILS_CACHE_ID])=
;
>         } else {
>                 return -EINVAL;
>         }
> +
>         if (info->attrs[NL80211_ATTR_PMK]) {
>                 pmksa.pmk =3D nla_data(info->attrs[NL80211_ATTR_PMK]);
>                 pmksa.pmk_len =3D nla_len(info->attrs[NL80211_ATTR_PMK]);
> --
> 2.32.0
>

--0000000000004c2adf060a550c3f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
mpwrn0/6Sf3DEFfysFSvrnhOv7DRZ1OuvLvE6won+W2My2cUk/GwsJigcfVOIeW+6k8HqYoeS5Gv
DqYgzE2mJ/xRXZNMUqRea8CP9NUSkK5n5JKnGBMFAgMBAAGjggHZMIIB1TAOBgNVHQ8BAf8EBAMC
BaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJlLmdsb2JhbHNp
Z24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYIKwYBBQUHMAGG
NWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwME0G
A1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxz
aWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqGOGh0dHA6Ly9j
cmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3JsMCMGA1UdEQQc
MBqBGGppdGh1LmphbmNlQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAfBgNVHSME
GDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUOaotQ254RGCyTOE3GmUYiOr6xQw
DQYJKoZIhvcNAQELBQADggEBAJQEmVAg5gHetC6cEpTOOkvxmlpVDUvrqLSJdclgVyEj1rM+Qc4q
VrkDMnRI9JpQ0XgPi+/oebdZ7NcqPnvkNyz1hU9T4i5KwG93YEvqKND02+TrR9TvNCqNhDV3v6qU
8aXoDtJuqSlkH8em+nzdVbHwp/4M9XNfKY2IaItl3wPDs1Ti4D6OewXG+hSmcsvbclgSvZTJnIJI
It9h7f+sXIxBghRNL631e4HsXTIi2U7EM1cnNupsDm6wZzg9O4bVtYexIi1fSy3xbOn+bxJOI4dM
pgEAAsnH2RekyBDHAWHW7qp7P+AXkLoNrQlGqs3r8W2eNgrwcxLphpakQ29LvhMxggJtMIICaQIB
ATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYDVQQDEyhH
bG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwYVVavV2kh654UE6cwDQYJ
YIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK/9fb1Q8Janae4Z+SGJjuq0qWl32wSSQexQ
+8QR/5qdMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIzMTExNzA4
MzczNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsGCWCGSAFl
AwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFlAwQCATAN
BgkqhkiG9w0BAQEFAASCAQArbMNhAyzt0vXwYDyZ5wUanlfQt5Dj11i5hxM0J3k1+CWw+IddOSjE
lRo2XP8fSSOxn2drOC5NzhDVOQ9uC/x691wQy31xKiqfwwXD0fmbAsFeMuIZ4A9eTMVzN6P5lL77
bxvl3/jNPoVxSAVdHZW5ZTrZdMK0XOQMmbEjR4pxfgUK38K3IpDmQ9/apsf122v/rYJwxilhCTqz
cy8hG43OaL9+ex/JQSwFIG4PDrCJcAI8Do0mmfQPVrMJLLV0VRhzZ+4vSgN4wVE1ytOZB34tZCYv
+CtDcHdZfdeTPm5pxU0PEARwTovrqHms4hgXqzbjemuQ2GJKI3kyYwPAtnA+
--0000000000004c2adf060a550c3f--
