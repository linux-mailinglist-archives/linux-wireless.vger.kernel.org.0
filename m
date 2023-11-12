Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23FB77E8F1A
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Nov 2023 09:05:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230318AbjKLIFE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 12 Nov 2023 03:05:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230216AbjKLIFD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 12 Nov 2023 03:05:03 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A7D2D7C
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 00:05:00 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id d2e1a72fcca58-6b709048d8eso2980600b3a.2
        for <linux-wireless@vger.kernel.org>; Sun, 12 Nov 2023 00:05:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699776300; x=1700381100; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=MCPz+LLdNV+OMS0ITTC7ljEwfSKVRnmW3O4azfs6WcA=;
        b=OLai0XCvv5ayyEs5XbHunY1fBI/nTy/p98KuA+Ab2N4faN5/1VAGzPw4DWxfMQpROo
         /BJT3jqib3o3AgQsJznNRNG8+q2iyt8gAf12RWmMR/KWzkDgKAJWR1LU63fp+JEdsatn
         xJF/091ZtyGsZSGZIlC4yi6Bp9LyIdOQM28Fvc6Bc2DPft6Y6Hjhv/ROkgFkan20N4f3
         cj8i7A9aBdUxUIhb5K98Nj4xOyapYRLEMDkt/wKgE4Zw9lZuyDXPkif1XD76zo5h4YH9
         7FbfOqWxjECYdYscaQ+KdsE+ZIQEHFNyjLpVk8bd0ukCfuWt0ea9/RaV1pgl18H7FTQa
         bPEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699776300; x=1700381100;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MCPz+LLdNV+OMS0ITTC7ljEwfSKVRnmW3O4azfs6WcA=;
        b=vY4jn5THrzfOriciPOTsSd6Z/L3vjY+W2oR34430pUAFSNTSkNRCPH+H3CM8ldGans
         FsRElf7GRFMCJywioxzP6PPGzrY+RLcGJk/42Q8uU64oRz4ZhKzf/zj5KGHQSF0dh3e4
         +e1FhjEJDWvEvFAvlnWDcYum5OHRhyttfp2qm84jfHeZdOtjf/rJ/sohK6uY25Qz2sWq
         +50pywRbzQBFF2l9K9kY5DO9E7TOKIEbAbqs6TbqDTEfFVuJk7zP2ZuhY7wBcmcH6hEe
         KIYN1V6osKTW0NGG8U3Hsdks0WCf2IKfHWbuYZs/DmuNAfXgvLij8ZWEZw0VNq+GzSQM
         XRoA==
X-Gm-Message-State: AOJu0YyY4WbTcKWWr4mUNMppvjMEJTCCzr2m86yuo8RgdepZ8pLANDV9
        /PuDY1B4k9HoQ495qdSmzqMhVSLAwCAoQA==
X-Google-Smtp-Source: AGHT+IF64oeMjwBto6kBHOKcV1zS4Ipo0hgg8xERT+w4dChYlfINGCvxeIFQCglyzpAXHqx5Orpjaw==
X-Received: by 2002:a17:902:b94a:b0:1cd:fbc7:2737 with SMTP id h10-20020a170902b94a00b001cdfbc72737mr1996657pls.52.1699776299609;
        Sun, 12 Nov 2023 00:04:59 -0800 (PST)
Received: from archie.me ([103.131.18.64])
        by smtp.gmail.com with ESMTPSA id l4-20020a170902eb0400b001c61901ed2esm2228034plb.219.2023.11.12.00.04.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Nov 2023 00:04:58 -0800 (PST)
Received: by archie.me (Postfix, from userid 1000)
        id B7385101C1E07; Sun, 12 Nov 2023 15:04:56 +0700 (WIB)
Date:   Sun, 12 Nov 2023 15:04:56 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Kalle Valo <kvalo@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Gregory Greenman <gregory.greenman@intel.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Johannes Berg <johannes@sipsolutions.net>,
        Miri Korenblit <miriam.rachel.korenblit@intel.com>,
        Anjaneyulu <pagadala.yesu.anjaneyulu@intel.com>
Subject: Re: New iwlwifi warning
Message-ID: <ZVCHKCumfnY0AGBP@archie.me>
References: <CAHk-=wix6kqQ5vHZXjOPpZBfM7mMm9bBZxi2Jh7XnaKCqVf94w@mail.gmail.com>
 <87a5rja129.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="s2I+/k1Zs5883t/R"
Content-Disposition: inline
In-Reply-To: <87a5rja129.fsf@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


--s2I+/k1Zs5883t/R
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 12, 2023 at 09:22:06AM +0200, Kalle Valo wrote:
> Linus Torvalds <torvalds@linux-foundation.org> writes:
>=20
> > I only noticed now, because it doesn't cause any issues, but that may
> > be because this only happens on my desktop, and I don't actually use
> > the wireless there...
> >
> > The WARN_ON in iwl_trans_configure() has started triggering as of this
> > merge window:
> >
> >         WARN_ON(iwl_cmd_groups_verify_sorted(trans_cfg));
> >
> > and causes the appended warning at bootup.
> >
> > Comments? Anything in particular you need from me for debugging?
> >
> >                 Linus
> >
> > ---
> >
> >     WARNING: CPU: 3 PID: 2060 at
> > drivers/net/wireless/intel/iwlwifi/mvm/../iwl-trans.h:1158
> > iwl_op_mode_mvm_start+0x969/0x970 [iwlmvm]
>=20
> I investigated a bit and at least two other people have reported this
> warning but I couldn't find any fix:
>=20
> https://lore.kernel.org/lkml/2fa930bb-54dd-4942-a88d-05a47c8e9731@gmail.c=
om/T/
>=20
> Adding also Johannes and Miri.
>=20

It seems like the culprit authour from the above regression report
(Anjaneyulu) missed the report (AFK?). Cc'ing him anyways. If there's
no response from him, let's revert the culprit.

Thanks.

--=20
An old man doll... just what I always wanted! - Clara

--s2I+/k1Zs5883t/R
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQSSYQ6Cy7oyFNCHrUH2uYlJVVFOowUCZVCHIwAKCRD2uYlJVVFO
o1C6AQDlKGAkcGaVxy0c5H1ovsqFXdHGTT4NVcwTJq2pqYUpSAEAt24YTIMusu1F
WqCYebMxUlaIu8wUMf6V3MoVhArLlAc=
=TbX2
-----END PGP SIGNATURE-----

--s2I+/k1Zs5883t/R--
