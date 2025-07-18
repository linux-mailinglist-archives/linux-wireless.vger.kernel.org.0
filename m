Return-Path: <linux-wireless+bounces-25661-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FD8EB0A548
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 15:37:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C09D97A442F
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Jul 2025 13:35:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C0C137750;
	Fri, 18 Jul 2025 13:37:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="IQIZwGDW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3350E12CD8B
	for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 13:37:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752845826; cv=none; b=SuqjPBw1QOKbW3jb9d/7wP6bFcZ50XqThmPGmi2ON9Y0sfblP8WrsgSJc4KR6uastoAR31txgy7NjXg7a5OI9+lQtLU+t+svgqEtFLvCnUtQjktuIM2u9piFKzt6KrHj+mhdafaIBezUHMEIEvOo/e2KyNGuketUxZ+0AlGPRA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752845826; c=relaxed/simple;
	bh=qxr0lo1TN0HaCQ7Fgn8BLcctimnaTlHOFjPoqfSkCzg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyP4FQzY1ma4d7c72j2vcgxXvk8GKf2NqmeShRceZ3IwokpA8P5o8vVPwtI/wA1suB7WwYpP11bnb/k+U5LTnd5fzE08kpSlLDWsiPNFJYRsNHwdXqBt7fskpFkJlU4qtE/W2ewp9Dx+L5YKOFNm0KwrTL+rViEBAztL6Xlj/jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=IQIZwGDW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so385968866b.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Jul 2025 06:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1752845822; x=1753450622; darn=vger.kernel.org;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qxr0lo1TN0HaCQ7Fgn8BLcctimnaTlHOFjPoqfSkCzg=;
        b=IQIZwGDWdFQxiuDguV1uvGYsuC8Oao1MnOV6TvN4EVmc/Hv5RVVqnw68/JcfQBrqJy
         1lMBxKv7NbZ8bjbXIkNVqRF/iYOx8wpGBHLan28dMCSof+lU/1zEPLbQ6KmmMJXi6Cru
         gT7wFo6JBhbgYT8zGBZy8LiNkkkpr9VI84bUSN7dJ/3+FpSlqmT7EggKDTyjRseWCgPG
         LyOTDbG4UeS8eZzzAXl0UvtuVb/AZXMjS5rv2NuVAJGc9BKGWjedcdgvg/b0UuUyO1Zr
         ghvDN37kLUm+9mPlO0bP0G2OmYb4idzd7+8h5F7uFFE1XFSyACUQs84FYWVbW7d5g6dk
         n4uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752845822; x=1753450622;
        h=in-reply-to:autocrypt:from:content-language:references:cc:to
         :subject:user-agent:mime-version:date:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qxr0lo1TN0HaCQ7Fgn8BLcctimnaTlHOFjPoqfSkCzg=;
        b=VB0BC3yCociTA9hADDys6srzmm1Gh2xjdURnNDy84AFv4/qQdWerMky1AC3sxS97cH
         XcCF/FqEpbx3EYHHjmMPe2Dr4rfts1ernjBJI051Y8a13PQPje2qg7AWtjgaXIwmVCtW
         0iNFxiPfw4TWh3GnKCMRpXfQkBej6HLzRE46Xo6RDt1eq41sAnNmUCjUU+HaDF9CXTyA
         S/d/FM5KZE/mvQTKfe4fIaE0CaHs4xXHvRBIbihWCsDIlxsPjz3D/mZEzGIjJ0Qi9D2b
         h1dpvJgCfTKP/O48/g7S1bZgRfHJL7xK4SFNa0F98f+sRBMIfbpA369KipWP4C/lxb0T
         jsiA==
X-Forwarded-Encrypted: i=1; AJvYcCUeJBaCMCa7/HWw3rgc59TUGKNLpT47itpIM0uATCAsNxdVr6OhOmElkq2+eEt4omWUuleQNDRLG8bZaYI4cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwgD4Lt2/rWNPku1e37bJC7kYG3HS7Y240YSrVMkrNhdm8OKi30
	qOJSLOB4hqjWaObdEjLkQAu5uIrcWvDKdPK0GCc+sBdL6rJ8s86Qt9dWbsknMyOfVkY=
X-Gm-Gg: ASbGnctI71dmhnQMdMvDrY/VVFcmo7CX5RW+qjbmZpEqcJvd0YlzS2Xto3kfrGRhz2K
	McSOHlfrcSQk7bnK6yiAsD38WJx/S9+ySV3Zr6yY118ADeVC8dlXkX8enLDv0LOn0c6FqrZtgCj
	a3OHZnTJ6CuuCQ7s6S+sItVeeWMjLS/j5zcs/e6o8L0kPtEEG5mxOiJAD4xWg1Nk7uIAE5jO0R4
	EzJCTf2HYwxJs4uPMyJA3Nii2XIsjtfGgSu4EVEFmUopt8kVGpGrzj05u6+RwR8d2bS7Za/ORMZ
	ejDF9BRTRkIv3E0aIR0Qlx/qCOgtBaJGtOzl/aLE+v68CgU9TmC+8vLTjVP/mhVMKNrFqsCgNK9
	Stbb3hJhRJdDMp4GtE2qaTf7ea2wexUGwLE4b/uHosM+1oFrLW3/llgWeUQd8b479btzEcXDgZw
	+AnFDT08T2C5dZhoDZErAEp+11khdUnOPG/t1MEn9Yteu/
X-Google-Smtp-Source: AGHT+IGRXSvT8NrU4jhoTjesWfENh9gKHP5kfnupJ/w3fqPHsnvgkcSRmM63jgcb144OZnu3MTsjnA==
X-Received: by 2002:a17:907:983:b0:ae0:54b9:dc17 with SMTP id a640c23a62f3a-ae9cdd8605amr976953266b.11.1752845822181;
        Fri, 18 Jul 2025 06:37:02 -0700 (PDT)
Received: from ?IPV6:2003:e5:8728:2b00:e047:1b8:d101:cf8e? (p200300e587282b00e04701b8d101cf8e.dip0.t-ipconnect.de. [2003:e5:8728:2b00:e047:1b8:d101:cf8e])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d4806sm123151766b.39.2025.07.18.06.37.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Jul 2025 06:37:01 -0700 (PDT)
Message-ID: <01dae2e9-dad7-465c-94ae-bcfbc2f96337@suse.com>
Date: Fri, 18 Jul 2025 15:36:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 7/8] xen/xenbus: Fix typo "notifer"
To: WangYuli <wangyuli@uniontech.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, alison.schofield@intel.com,
 andrew+netdev@lunn.ch, andriy.shevchenko@linux.intel.com,
 arend.vanspriel@broadcom.com, bp@alien8.de,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 colin.i.king@gmail.com, cvam0000@gmail.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, dave.jiang@intel.com, dave@stgolabs.net,
 davem@davemloft.net, dri-devel@lists.freedesktop.org, edumazet@google.com,
 gregkh@linuxfoundation.org, guanwentao@uniontech.com, hpa@zytor.com,
 ilpo.jarvinen@linux.intel.com, intel-xe@lists.freedesktop.org,
 ira.weiny@intel.com, j@jannau.net, jeff.johnson@oss.qualcomm.com,
 jirislaby@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com,
 kuba@kernel.org, kvalo@kernel.org, kvm@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux@treblig.org, lucas.demarchi@intel.com, marcin.s.wojtas@gmail.com,
 ming.li@zohomail.com, mingo@kernel.org, mingo@redhat.com,
 netdev@vger.kernel.org, niecheng1@uniontech.com,
 oleksandr_tyshchenko@epam.com, pabeni@redhat.com, pbonzini@redhat.com,
 quic_ramess@quicinc.com, ragazenta@gmail.com, rodrigo.vivi@intel.com,
 seanjc@google.com, shenlichuan@vivo.com, simona@ffwll.ch,
 sstabellini@kernel.org, tglx@linutronix.de,
 thomas.hellstrom@linux.intel.com, vishal.l.verma@intel.com, x86@kernel.org,
 xen-devel@lists.xenproject.org, yujiaoliang@vivo.com, zhanjun@uniontech.com
References: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
 <906F22CD3C183048+20250715134407.540483-7-wangyuli@uniontech.com>
Content-Language: en-US
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
Autocrypt: addr=jgross@suse.com; keydata=
 xsBNBFOMcBYBCACgGjqjoGvbEouQZw/ToiBg9W98AlM2QHV+iNHsEs7kxWhKMjrioyspZKOB
 ycWxw3ie3j9uvg9EOB3aN4xiTv4qbnGiTr3oJhkB1gsb6ToJQZ8uxGq2kaV2KL9650I1SJve
 dYm8Of8Zd621lSmoKOwlNClALZNew72NjJLEzTalU1OdT7/i1TXkH09XSSI8mEQ/ouNcMvIJ
 NwQpd369y9bfIhWUiVXEK7MlRgUG6MvIj6Y3Am/BBLUVbDa4+gmzDC9ezlZkTZG2t14zWPvx
 XP3FAp2pkW0xqG7/377qptDmrk42GlSKN4z76ELnLxussxc7I2hx18NUcbP8+uty4bMxABEB
 AAHNH0p1ZXJnZW4gR3Jvc3MgPGpncm9zc0BzdXNlLmNvbT7CwHkEEwECACMFAlOMcK8CGwMH
 CwkIBwMCAQYVCAIJCgsEFgIDAQIeAQIXgAAKCRCw3p3WKL8TL8eZB/9G0juS/kDY9LhEXseh
 mE9U+iA1VsLhgDqVbsOtZ/S14LRFHczNd/Lqkn7souCSoyWsBs3/wO+OjPvxf7m+Ef+sMtr0
 G5lCWEWa9wa0IXx5HRPW/ScL+e4AVUbL7rurYMfwCzco+7TfjhMEOkC+va5gzi1KrErgNRHH
 kg3PhlnRY0Udyqx++UYkAsN4TQuEhNN32MvN0Np3WlBJOgKcuXpIElmMM5f1BBzJSKBkW0Jc
 Wy3h2Wy912vHKpPV/Xv7ZwVJ27v7KcuZcErtptDevAljxJtE7aJG6WiBzm+v9EswyWxwMCIO
 RoVBYuiocc51872tRGywc03xaQydB+9R7BHPzsBNBFOMcBYBCADLMfoA44MwGOB9YT1V4KCy
 vAfd7E0BTfaAurbG+Olacciz3yd09QOmejFZC6AnoykydyvTFLAWYcSCdISMr88COmmCbJzn
 sHAogjexXiif6ANUUlHpjxlHCCcELmZUzomNDnEOTxZFeWMTFF9Rf2k2F0Tl4E5kmsNGgtSa
 aMO0rNZoOEiD/7UfPP3dfh8JCQ1VtUUsQtT1sxos8Eb/HmriJhnaTZ7Hp3jtgTVkV0ybpgFg
 w6WMaRkrBh17mV0z2ajjmabB7SJxcouSkR0hcpNl4oM74d2/VqoW4BxxxOD1FcNCObCELfIS
 auZx+XT6s+CE7Qi/c44ibBMR7hyjdzWbABEBAAHCwF8EGAECAAkFAlOMcBYCGwwACgkQsN6d
 1ii/Ey9D+Af/WFr3q+bg/8v5tCknCtn92d5lyYTBNt7xgWzDZX8G6/pngzKyWfedArllp0Pn
 fgIXtMNV+3t8Li1Tg843EXkP7+2+CQ98MB8XvvPLYAfW8nNDV85TyVgWlldNcgdv7nn1Sq8g
 HwB2BHdIAkYce3hEoDQXt/mKlgEGsLpzJcnLKimtPXQQy9TxUaLBe9PInPd+Ohix0XOlY+Uk
 QFEx50Ki3rSDl2Zt2tnkNYKUCvTJq7jvOlaPd6d/W0tZqpyy7KVay+K4aMobDsodB3dvEAs6
 ScCnh03dDAFgIq5nsB11j3KPKdVoPlfucX2c7kGNH+LUMbzqV6beIENfNexkOfxHfw==
In-Reply-To: <906F22CD3C183048+20250715134407.540483-7-wangyuli@uniontech.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------cT4r0JNOUrsPfSEaUgW0eBEO"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------cT4r0JNOUrsPfSEaUgW0eBEO
Content-Type: multipart/mixed; boundary="------------oGJ4EHAKnSBOvFH3NUzTflx0";
 protected-headers="v1"
From: =?UTF-8?B?SsO8cmdlbiBHcm/Dnw==?= <jgross@suse.com>
To: WangYuli <wangyuli@uniontech.com>
Cc: airlied@gmail.com, akpm@linux-foundation.org, alison.schofield@intel.com,
 andrew+netdev@lunn.ch, andriy.shevchenko@linux.intel.com,
 arend.vanspriel@broadcom.com, bp@alien8.de,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 colin.i.king@gmail.com, cvam0000@gmail.com, dan.j.williams@intel.com,
 dave.hansen@linux.intel.com, dave.jiang@intel.com, dave@stgolabs.net,
 davem@davemloft.net, dri-devel@lists.freedesktop.org, edumazet@google.com,
 gregkh@linuxfoundation.org, guanwentao@uniontech.com, hpa@zytor.com,
 ilpo.jarvinen@linux.intel.com, intel-xe@lists.freedesktop.org,
 ira.weiny@intel.com, j@jannau.net, jeff.johnson@oss.qualcomm.com,
 jirislaby@kernel.org, johannes.berg@intel.com, jonathan.cameron@huawei.com,
 kuba@kernel.org, kvalo@kernel.org, kvm@vger.kernel.org,
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-serial@vger.kernel.org, linux-wireless@vger.kernel.org,
 linux@treblig.org, lucas.demarchi@intel.com, marcin.s.wojtas@gmail.com,
 ming.li@zohomail.com, mingo@kernel.org, mingo@redhat.com,
 netdev@vger.kernel.org, niecheng1@uniontech.com,
 oleksandr_tyshchenko@epam.com, pabeni@redhat.com, pbonzini@redhat.com,
 quic_ramess@quicinc.com, ragazenta@gmail.com, rodrigo.vivi@intel.com,
 seanjc@google.com, shenlichuan@vivo.com, simona@ffwll.ch,
 sstabellini@kernel.org, tglx@linutronix.de,
 thomas.hellstrom@linux.intel.com, vishal.l.verma@intel.com, x86@kernel.org,
 xen-devel@lists.xenproject.org, yujiaoliang@vivo.com, zhanjun@uniontech.com
Message-ID: <01dae2e9-dad7-465c-94ae-bcfbc2f96337@suse.com>
Subject: Re: [PATCH v2 7/8] xen/xenbus: Fix typo "notifer"
References: <BD5C52D2838AEA48+20250715134050.539234-1-wangyuli@uniontech.com>
 <906F22CD3C183048+20250715134407.540483-7-wangyuli@uniontech.com>
In-Reply-To: <906F22CD3C183048+20250715134407.540483-7-wangyuli@uniontech.com>

--------------oGJ4EHAKnSBOvFH3NUzTflx0
Content-Type: multipart/mixed; boundary="------------iEXRbWM0AKXbkOVtyXZqSTc3"

--------------iEXRbWM0AKXbkOVtyXZqSTc3
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gMTUuMDcuMjUgMTU6NDQsIFdhbmdZdWxpIHdyb3RlOg0KPiBUaGVyZSBpcyBhIHNwZWxs
aW5nIG1pc3Rha2Ugb2YgJ25vdGlmZXInIGluIHRoZSBjb21tZW50IHdoaWNoDQo+IHNob3Vs
ZCBiZSAnbm90aWZpZXInLg0KPiANCj4gTGluazogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
YWxsL0IzQzAxOUI2M0M5Mzg0NkYrMjAyNTA3MTUwNzEyNDUuMzk4ODQ2LTEtd2FuZ3l1bGlA
dW5pb250ZWNoLmNvbS8NCj4gU2lnbmVkLW9mZi1ieTogV2FuZ1l1bGkgPHdhbmd5dWxpQHVu
aW9udGVjaC5jb20+DQoNClJldmlld2VkLWJ5OiBKdWVyZ2VuIEdyb3NzIDxqZ3Jvc3NAc3Vz
ZS5jb20+DQoNCg0KSnVlcmdlbg0K
--------------iEXRbWM0AKXbkOVtyXZqSTc3
Content-Type: application/pgp-keys; name="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Disposition: attachment; filename="OpenPGP_0xB0DE9DD628BF132F.asc"
Content-Description: OpenPGP public key
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP PUBLIC KEY BLOCK-----

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
kt+z4drzFUyEjLM1vVvIMjkUoJs=3D
=3DeeAB
-----END PGP PUBLIC KEY BLOCK-----

--------------iEXRbWM0AKXbkOVtyXZqSTc3--

--------------oGJ4EHAKnSBOvFH3NUzTflx0--

--------------cT4r0JNOUrsPfSEaUgW0eBEO
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsB5BAABCAAjFiEEhRJncuj2BJSl0Jf3sN6d1ii/Ey8FAmh6TfsFAwAAAAAACgkQsN6d1ii/Ey8c
Ygf/U0f6aO6tXuLVLY6fZvfaFWhIB7EB2CVm4zKF7LgVe0t84C2fovOiSsaEQZha5J86f+37KuMH
ahCur6raARzYTpUM//Os66LLW5nTG8yKd89CnE24MFDJsUdnv5qPqF4jb/wYDtr8xvuKwWEqWZz2
gWXCJNYry4wnZucm2Y0O4ylQXLJOzaDyc7Q3mnobvAJEuAbqPgoJCuMYaU2M9o7b4X4l2TO9lVAz
VaKGeVaTbiu8ys+JRy35HTdHyKboyr8Johi1iRtV42/+5rxr1fWIeQfGEBnOEXnzi6URr8HOKFSr
pdIJDp/rLD79JiOzGRZXBJZ2l8jybh7o7dN5y7z7Kg==
=9yKc
-----END PGP SIGNATURE-----

--------------cT4r0JNOUrsPfSEaUgW0eBEO--

