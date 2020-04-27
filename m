Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99D51B9820
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 09:07:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgD0HH6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 03:07:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726504AbgD0HH6 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 03:07:58 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8AA4C061A0F
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2020 00:07:57 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so726573plr.0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2020 00:07:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=RoIStb/CvsXCEpSgHK/fK/4tNC/cHrihDmDfk31ObMc=;
        b=PeIb0OC73L3O6OnawBuSdUxJpps/O6H4k7F5lLPu72LSj2rcYmkY1XkfvhlUgPQwdN
         dLxZbUGm3BthHG+WGGLRexVnDaUFY0R8jk/oLk0+kZ85xbYCihPiplHvASGkO0J+eqUE
         w3xZDvaknkyXskJQOG9LJx/LodHQ4RfW313vxrplQQO8jnJc//aceAM3Rfq0vLqS5I9F
         vK8290POGL3rti5k2odTOQ7RO5MJPs9ZgxHjAWFD4JMYFMFQ5ZmWlwtyA+rFnJwDk1WV
         NvrbIKEKNiMeIMZzP/EszxThJx+z/4IfC+oBhkRjbxXRMg19TLDZIUKcfsc/HS7X86cO
         JrrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:autocrypt:message-id
         :date:user-agent:mime-version:in-reply-to;
        bh=RoIStb/CvsXCEpSgHK/fK/4tNC/cHrihDmDfk31ObMc=;
        b=tpA9XufdiFAaHHNau4gvSToD99qaAXIOkiQbq5pl3jy+8ppgUTP6YXrYpRX+l4Cgwz
         E00uUMe4fgC5quePK2uF8YMzBPf3n/VKf7FMtgZRLnNrb++itHsLLs5HhxaiaBBZqIQV
         V3HR2X/frE/6rgPrm7ePOaKV8YjZrdfSnFibj1VRN2V7rCvX9yrMw9v2pcBOmwkAJzRg
         EHR8YGelpmPx6SJyqrIwakNk92mTVFoe/iA4Dfq4Ws20fuaJaea4DJwkNLjRLAMsp8+t
         oByoMR/YIFk3vVq3Sxp7yUz0WFLHSGsyKyfN8CuwtoMR1Rf4K1PI+x57I1XCd/u1f7T1
         rn3w==
X-Gm-Message-State: AGi0Pua9dHUsTaaLlTEYMCo+1ER7Rbt7/GVhWl8AOYc/C3RHTkEaaTys
        bUye9LnxmWVy1rvRgoGgTztURI9c3Ko=
X-Google-Smtp-Source: APiQypI242SsddKzrfRnYYZx56XFdm8gla2JsNg/yPmt6SH1X1Wd5ajowMYGUB8xjwq/6YzOBKwO/A==
X-Received: by 2002:a17:90a:cb86:: with SMTP id a6mr21949813pju.127.1587971276428;
        Mon, 27 Apr 2020 00:07:56 -0700 (PDT)
Received: from [10.101.46.193] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id g9sm10118333pgj.89.2020.04.27.00.07.54
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 00:07:55 -0700 (PDT)
Subject: Re: [PATCH v5.7] iwlwifi: pcie: handle QuZ configs with killer NICs
 as well
To:     linux-wireless@vger.kernel.org
References: <iwlwifi.20200424121518.b715acfbe211.I273a098064a22577e4fca767910fd9cf0013f5cb@changeid>
 <20200426150338.B769E206D4@mail.kernel.org>
From:   You-Sheng Yang <vicamo@gmail.com>
Autocrypt: addr=vicamo@gmail.com; keydata=
 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
 /7MpmAIm
Message-ID: <2aba29a6-ebd3-46c0-afd0-9245f9cc0a1a@gmail.com>
Date:   Mon, 27 Apr 2020 15:07:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200426150338.B769E206D4@mail.kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="wbIpvfp5ZWaDHI1oBz5lEdRbMXOmAF5Dr"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wbIpvfp5ZWaDHI1oBz5lEdRbMXOmAF5Dr
Content-Type: multipart/mixed; boundary="ON1QogXLdtcl4kFTGD7CCcqeo1QX5WlEe"

--ON1QogXLdtcl4kFTGD7CCcqeo1QX5WlEe
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi,

I also bumped into this error when back porting this patch.

$ git log --graph --oneline --decorate=3Dno \
    ubuntu/focal korg/master \
    -- drivers/net/wireless/intel/iwlwifi/pcie/drv.c
* d28fb205177d iwlwifi: assume the driver_data is a trans_cfg, but allow
full cfg
* f2e49f9481d3 iwlwifi: remove some outdated iwl22000 configurations
* ea07f3d33270 iwlwifi: allocate more receive buffers for HE devices
* 768a892b00b7 Revert "iwlwifi: assign directly to iwl_trans->cfg in QuZ
detection"
| *   fafa7424ba7d Merge tag 'iwlwifi-next-for-kalle-2020-01-11' of
git://git.kernel.org/pub/scm/linux/kernel/git/iwlwifi/iwlwifi-next
| |\
| | * 0b295a1eb81f iwlwifi: add device name to device_info
| | * 2a612a60ab44 iwlwifi: implement a new device configuration table
| | * b3bd6416fc77 iwlwifi: assume the driver_data is a trans_cfg, but
allow full cfg
| | * 6dece0e99faa iwlwifi: remove CSR registers abstraction
| | * b81b7bd02eda iwlwifi: remove some outdated iwl22000 configurations
| | * c042f0c77f3d iwlwifi: allocate more receive buffers for HE devices
| |/
|/|
| * db5cce1afc8d Revert "iwlwifi: assign directly to iwl_trans->cfg in
QuZ detection"
|/
* 17c216ed6b9e iwlwifi: pcie: 0x2720 is qu and 0x30DC is not

d28fb205177d: ubuntu/focal
fafa7424ba7d: korg/master

And we have file difference:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
$ git diff ubuntu/focal korg/master \
    -- drivers/net/wireless/intel/iwlwifi/pcie/drv.c
=2E.....
@@ -1125,17 +1145,17 @@ static int iwl_pci_probe(struct pci_dev *pdev,
const struct pci_device_id *ent)
        /* same thing for QuZ... */
        if (iwl_trans->hw_rev =3D=3D CSR_HW_REV_TYPE_QUZ) {
                if (cfg =3D=3D &iwl_ax101_cfg_qu_hr)
-                       iwl_trans->cfg =3D &iwl_ax101_cfg_quz_hr;
+                       cfg =3D &iwl_ax101_cfg_quz_hr;
                else if (cfg =3D=3D &iwl_ax201_cfg_qu_hr)
-                       iwl_trans->cfg =3D &iwl_ax201_cfg_quz_hr;
+                       cfg =3D &iwl_ax201_cfg_quz_hr;
                else if (cfg =3D=3D &iwl9461_2ac_cfg_qu_b0_jf_b0)
-                       iwl_trans->cfg =3D &iwl9461_2ac_cfg_quz_a0_jf_b0_=
soc;
+                       cfg =3D &iwl9461_2ac_cfg_quz_a0_jf_b0_soc;
                else if (cfg =3D=3D &iwl9462_2ac_cfg_qu_b0_jf_b0)
-                       iwl_trans->cfg =3D &iwl9462_2ac_cfg_quz_a0_jf_b0_=
soc;
+                       cfg =3D &iwl9462_2ac_cfg_quz_a0_jf_b0_soc;
                else if (cfg =3D=3D &iwl9560_2ac_cfg_qu_b0_jf_b0)
-                       iwl_trans->cfg =3D &iwl9560_2ac_cfg_quz_a0_jf_b0_=
soc;
+                       cfg =3D &iwl9560_2ac_cfg_quz_a0_jf_b0_soc;
                else if (cfg =3D=3D &iwl9560_2ac_160_cfg_qu_b0_jf_b0)
-                       iwl_trans->cfg =3D
&iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
+                       cfg =3D &iwl9560_2ac_160_cfg_quz_a0_jf_b0_soc;
        }

 #endif
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

It seems there is a merge error in upstream merge commit fafa7424ba7d,
that it confused the meaning in commit db5cce1afc8d and b3bd6416fc77.
How do you think?

Ubuntu Focal kernel:
https://git.launchpad.net/~ubuntu-kernel/ubuntu/+source/linux/+git/focal

You-Sheng Yang

On 2020-04-26 23:03, Sasha Levin wrote:
> Hi
>=20
> [This is an automated email]
>=20
> This commit has been processed because it contains a "Fixes:" tag
> fixing commit: 5a8c31aa6357 ("iwlwifi: pcie: fix recognition of QuZ dev=
ices").
>=20
> The bot has tested the following trees: v5.6.7, v5.4.35.
>=20
> v5.6.7: Failed to apply! Possible dependencies:
>     32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new c=
onfig table")
>     56ba371a5288 ("iwlwifi: move the remaining 0x2526 configs to the ne=
w table")
>     5e003982b07a ("iwlwifi: move AX200 devices to the new table")
>     67eb556da609 ("iwlwifi: combine 9260 cfgs that only change names")
>     95939551e28c ("iwlwifi: add GNSS differentiation to the device tabl=
es")
>     d6f2134a3831 ("iwlwifi: add mac/rf types and 160MHz to the device t=
ables")
>     fe25b1518f72 ("iwlwifi: move TH1 devices to the new table")
>=20
> v5.4.35: Failed to apply! Possible dependencies:
>     32ed101aa140 ("iwlwifi: convert all Qu with Jf devices to the new c=
onfig table")
>     3681021fc6af ("iwlwifi: remove IWL_DEVICE_22560/IWL_DEVICE_FAMILY_2=
2560")
>     3b589d5624ce ("iwlwifi: dbg_ini: use new trigger TLV in dump flow")=

>     593fae3e5e90 ("iwlwifi: dbg_ini: add monitor dumping support")
>     69f0e5059b09 ("iwlwifi: dbg: remove multi buffers infra")
>     bfc3e9fdbfb8 ("iwlwifi: 22000: fix some indentation")
>     c042f0c77f3d ("iwlwifi: allocate more receive buffers for HE device=
s")
>     c9fe75e9f347 ("iwlwifi: dbg_ini: use new region TLV in dump flow")
>=20
>=20
> NOTE: The patch will not be queued to stable trees until it is upstream=
=2E
>=20
> How should we proceed with this patch?
>=20


--ON1QogXLdtcl4kFTGD7CCcqeo1QX5WlEe--

--wbIpvfp5ZWaDHI1oBz5lEdRbMXOmAF5Dr
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEVhtdp+wXuXuqVL95S6BJ+2O0nE8FAl6mhMIACgkQS6BJ+2O0
nE+b4QgAm65jcJ3VTIpdav6rfu7HbFtqOp0ckX2qABz96jEvfhBpYzWRNGplm3Ka
v2iiHxXJgWFhMONkPYCS8ArCqOkBiL6JbtjmggVVi6APHSxQv+Eb38PbQrtMqBgB
UQNl+Zk+RJ6WTSrXf2OpaZl7R2pEEYnNqWakNaKheGzJbsj5F4zquHfaehfg6Q8z
mhrzsNXqZumgYwIq6NEgMuQUBNiKGxwXRvzEd18NGVi1Z0WF5Z4Vor/IK3ydSJqT
HyQWxYhUhDyGiyjTVNSJn2z9VMokdnSBQjbT3t+hUE3wEzFI/Z9zp4ORGYv6db1N
fsMAe0mcyOlxgXtXGpoZ0Y8HyJX/yQ==
=yeG/
-----END PGP SIGNATURE-----

--wbIpvfp5ZWaDHI1oBz5lEdRbMXOmAF5Dr--
