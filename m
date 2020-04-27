Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40BE31BA2F1
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Apr 2020 13:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726604AbgD0Lvk (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Apr 2020 07:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726260AbgD0Lvk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Apr 2020 07:51:40 -0400
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com [IPv6:2607:f8b0:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A178C0610D5
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2020 04:51:40 -0700 (PDT)
Received: by mail-pf1-x441.google.com with SMTP id y25so8900792pfn.5
        for <linux-wireless@vger.kernel.org>; Mon, 27 Apr 2020 04:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to;
        bh=Phu/i9VFDJtQJxCPonceNj1I6SmoH3LCzanqtt762js=;
        b=pw8Z5phMinYDbAf1VuEwmFciw5zQNC/JKWLXcn4oM1TmwI4ktHkNGEPTHrXaquae5y
         TRbx/mpn2desQmgx1Me2xYk7agZ0dq0R/7bpn7JNlJgDOyTgT5Gq75k+vZWC5YAsRQJD
         2nGWb7CHjFYKsHt1KnXKTQCsOxRTCAxBYJ9727HZ7Djv6y+puH5T2fGz02mrIl5bhm7H
         O4cW97umpXw6PgL/kXBIu7yTrEq3QYOeB7liEyJjsn2Rec2ruCLGtUHOch+DEXlqtAYt
         ksnRdydCtB7NvFJLwTu3QNa3n4f+YIjU6R0k21CNLAkWCEKAfcOxgnCse6+yRrq8eDfn
         c3mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to;
        bh=Phu/i9VFDJtQJxCPonceNj1I6SmoH3LCzanqtt762js=;
        b=EiRt6Vb8f+3TfDA6yGF2T9GuNGZEYVuOt9jq6wpMYe9krzXoaO45o0FOgDOKQ2QuvU
         XgiyGd+EXO5zdeaP63LoZ9+AOSA5Mszv/bibzb7BfQ+xld7kEE96ZrnILmpXWP/rlyNJ
         o0EScUlWlf97geSsOE8V0h1M8U6F7igrDMivPnTGQrtudqt9skPkXRtZJwXCjWRv9VsS
         x4mgemmils8goI8K/uJgjRE9TOUE6mXEDUoPy41PHuxOb2yYTB0BkrDKqz5mp/H/T8UF
         dA+ImD1wi2dFDSZU4B+01tGvA6hgvoVyvyJw3JOJQcRLU7iHF9MTlHpbwWJtlVcxzzLN
         l7XA==
X-Gm-Message-State: AGi0PuazRuLXnAls0mDGs6z6fQ1vaawJSGtFoEtfu/ZXwogel1YcHFRf
        QaUkg9MxgdzaBlb0DmE9Kpe/VMyaAKU=
X-Google-Smtp-Source: APiQypJCVf8esdjtH8F9ndBCf3mQuDuuMfp5eynxFwkbl7hVvRhzMB9UleAlHu8dpAWsOE0fgFPglw==
X-Received: by 2002:a63:5642:: with SMTP id g2mr23285942pgm.211.1587988298978;
        Mon, 27 Apr 2020 04:51:38 -0700 (PDT)
Received: from [10.101.46.193] (61-220-137-37.HINET-IP.hinet.net. [61.220.137.37])
        by smtp.gmail.com with ESMTPSA id c15sm12264407pfo.188.2020.04.27.04.51.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Apr 2020 04:51:37 -0700 (PDT)
Subject: Re: [PATCH v5.7] iwlwifi: pcie: handle QuZ configs with killer NICs
 as well
From:   You-Sheng Yang <vicamo@gmail.com>
To:     Luca Coelho <luca@coelho.fi>
Cc:     kvalo@codeaurora.org, linux-wireless@vger.kernel.org
References: <iwlwifi.20200424121518.b715acfbe211.I273a098064a22577e4fca767910fd9cf0013f5cb@changeid>
 <f056d364-d85d-8acd-dd74-7d1b64f6d6ae@gmail.com>
Autocrypt: addr=vicamo@gmail.com; keydata=
 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
 /7MpmAIm
Message-ID: <a0c8da44-1daa-07ba-3837-34f4d1aefb28@gmail.com>
Date:   Mon, 27 Apr 2020 19:51:26 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <f056d364-d85d-8acd-dd74-7d1b64f6d6ae@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="HkHwLSSIQVXT8mC3wdblqaKfxWp3bP6E2"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HkHwLSSIQVXT8mC3wdblqaKfxWp3bP6E2
Content-Type: multipart/mixed; boundary="BhJMv8xGUuDeJWEXvq0ZHqDLUBrWq6gt5"

--BhJMv8xGUuDeJWEXvq0ZHqDLUBrWq6gt5
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

[update]

With that cfg/iwl_trans->cfg usage corrected, this patch brings Killer
series back to live. Thank you.

Tested-by: You-Sheng Yang <vicamo@gmail.com>

On 2020-04-27 14:50, You-Sheng Yang wrote:
> Hi Luca,
>=20
> I have backported this to Ubuntu kernels in my ppa[1], and it doesn't
> really fix firmware crash on Killer(R) Wi-Fi 6 AX1650i 160MHz Wireless
> Network Adapter (201NGW), REV=3D0x354 [8086:a0f0] subsystem id [1a56:16=
51].
>=20
> [1]: https://launchpad.net/~vicamo/+archive/ubuntu/ppa-1874685
>=20
> You-Sheng Yang
>=20
> On 2020-04-24 17:20, Luca Coelho wrote:
>> From: Luca Coelho <luciano.coelho@intel.com>
>>
>> The killer devices were left out of the checks that convert Qu-B0 to
>> QuZ configurations.  Add them.
>>
>> Cc: stable@vger.kernel.org # v5.3+
>> Fixes: 5a8c31aa6357 ("iwlwifi: pcie: fix recognition of QuZ devices")
>> Signed-off-by: Luca Coelho <luciano.coelho@intel.com>
>> ---
>>  drivers/net/wireless/intel/iwlwifi/pcie/drv.c | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c b/drivers/n=
et/wireless/intel/iwlwifi/pcie/drv.c
>> index 6744c0281ffb..29971c25dba4 100644
>> --- a/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> +++ b/drivers/net/wireless/intel/iwlwifi/pcie/drv.c
>> @@ -1092,6 +1092,10 @@ static int iwl_pci_probe(struct pci_dev *pdev, =
const struct pci_device_id *ent)
>>  			iwl_trans->cfg =3D &iwl_ax101_cfg_quz_hr;
>>  		else if (iwl_trans->cfg =3D=3D &iwl_ax201_cfg_qu_hr)
>>  			iwl_trans->cfg =3D &iwl_ax201_cfg_quz_hr;
>> +		else if (iwl_trans->cfg =3D=3D &killer1650s_2ax_cfg_qu_b0_hr_b0)
>> +			iwl_trans->cfg =3D &iwl_ax1650s_cfg_quz_hr;
>> +		else if (iwl_trans->cfg =3D=3D &killer1650i_2ax_cfg_qu_b0_hr_b0)
>> +			iwl_trans->cfg =3D &iwl_ax1650i_cfg_quz_hr;
>>  	}
>> =20
>>  #endif
>>
>=20


--BhJMv8xGUuDeJWEXvq0ZHqDLUBrWq6gt5--

--HkHwLSSIQVXT8mC3wdblqaKfxWp3bP6E2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEVhtdp+wXuXuqVL95S6BJ+2O0nE8FAl6mxz4ACgkQS6BJ+2O0
nE/FUggAgxHC6IyqpGIbWkUri5Kz4jP4GCmcIh9ueumWYl3Q8Xmv9uvIpIvFuwQu
TScUmemEKMCLxK/pWd0bZ5WQTin71jsFmqt76cKH214MZUv+K2iBbdyY0s/cgqtW
bqDBIeD2yAaHRUJBhs1OMsn3vlh7KF7ciSN5Fe7AC5xPQInUYL1wuVHAklHXMwhD
jIAp5EdSC9geOifegfgknfyy8kf58XUGkUTtbrBsCraytMHnRcpjH6Id11ZJwN/5
+oIelO68zTv4IVe7qGlcTZxqRUbaqNKlG/lPRXJZ07lo50TjCh0838wQXVNoYFnv
zbASPyTJrPN0ha79RdPKwu8GoCpaMQ==
=zgWR
-----END PGP SIGNATURE-----

--HkHwLSSIQVXT8mC3wdblqaKfxWp3bP6E2--
