Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3AC37D4764
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Oct 2023 08:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjJXGXn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Oct 2023 02:23:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230017AbjJXGXn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Oct 2023 02:23:43 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55978C0
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 23:23:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A4EC433C8
        for <linux-wireless@vger.kernel.org>; Tue, 24 Oct 2023 06:23:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698128617;
        bh=lb8PcZAj9HDSGOv4bV1UcMMj2pMBE+0lqDt8MZp4ERI=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=M2uax59eEm84/YsEmxWrFbHtxfC3ogO+Ahn4QtDgtFogcM+4FRamUE0tB8LKUK3Yo
         e5kGRIBIHToFD6e4ZypvlVaFtQLG1iR4mb+B5lgGobWOG7yGInJqt54CySqyIQymEj
         q8bs6g97oKhp5nfv3cUvMOF5kV+ulqhsm4a1J3/LycJgb4P5rH/mHG3noFXuzmkyyS
         7Kgin15ZfALfTNDqJ1Yd5jogA9tDj5+RDws/9JUgGo/SPkk8A1iCbUNhVlpcGQtb51
         zUXf3fvtLMynOx5d1b0jevbOEAQnBV3uo+L8KBzG2NSOHfLW79b8yUao2o55c9Qji3
         Mg5hF+fO8hYHg==
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-6b36e1fcee9so3414115b3a.3
        for <linux-wireless@vger.kernel.org>; Mon, 23 Oct 2023 23:23:37 -0700 (PDT)
X-Gm-Message-State: AOJu0YypYAMLSTslYplE7fMDDWQbP/U4OTxpj086QPSEQWdzfPi1t2vd
        pIyCGuqOfvFh3SA3LxpKGGhhcvF6M9XDfcmryCg=
X-Google-Smtp-Source: AGHT+IHMVZw+A0ImlbGytJR8Q+3as+dkdoHhC3uiC4eh39tQujC0q5xpSGxCFM2TmdQ/zKFvRxQajMRgjR813kXri7M=
X-Received: by 2002:a05:6a21:66c9:b0:14b:7d8b:cbaf with SMTP id
 ze9-20020a056a2166c900b0014b7d8bcbafmr1527501pzb.57.1698128617446; Mon, 23
 Oct 2023 23:23:37 -0700 (PDT)
MIME-Version: 1.0
References: <ZPJF1/2YA4dP+ggY@ubuntu-x1>
In-Reply-To: <ZPJF1/2YA4dP+ggY@ubuntu-x1>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 24 Oct 2023 14:23:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com>
Message-ID: <CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com>
Subject: Re: [wireless-regdb] [ANN] wireless-regdb: master-2023-09-01
To:     Seth Forshee <sforshee@kernel.org>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Seth,

On Sat, Sep 2, 2023 at 4:13=E2=80=AFAM Seth Forshee <sforshee@kernel.org> w=
rote:
>
> A new release of wireless-regdb (master-2023-09-01) is available at:
>
> https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb=
-2023.09.01.tar.xz
>
> The short log of changes since the master-2022-05-03 release is below.
>
> As previously announced, I am stepping down as the maintainer of
> wireless-regdb effective today. This is the last release I plan to do,
> and currently there is no new maintainer for the project.

I'd like to take up maintainership.

As far as I know, I would need to:

1. Make a clone of the repository on git.kernel.org under my own namespace.
2. Generate a key pair and certificate
3. Put the certificate into the kernel tree
4. Update the docs to point to the new repository and certificate
5. Review incoming patches and apply them
6. Tag releases timely

I'm not sure if I missed anything.


Thanks
ChenYu

> Thanks,
> Seth
>
> ---
>
> Adam Nielsen (1):
>       wireless-regdb: Update regulatory rules for Australia (AU) for June=
 2023
>
> Seth Forshee (3):
>       wireless-regdb: Update regulatory rules for Egypt (EG) from March 2=
022 guidelines
>       wireless-regdb: Update regulatory info for T=C3=BCrkiye (TR)
>       wireless-regdb: update regulatory database based on preceding chang=
es
>
> kleo (1):
>       wireless-regdb: Update regulatory rules for Philippines (PH)
>
>
> _______________________________________________
> wireless-regdb mailing list
> wireless-regdb@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/wireless-regdb
