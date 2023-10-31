Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1407DC9AE
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Oct 2023 10:32:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343929AbjJaJce (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Oct 2023 05:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343923AbjJaJce (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Oct 2023 05:32:34 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB79EB7
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 02:32:26 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DE9C433C8
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 09:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698744746;
        bh=uFgBPpvtFnSyCFYwY97t4H00HZ5VRzhmUWbnbsuu23U=;
        h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
        b=fsjkVXM12nJEGZwqGDBBQjpq5KPqdeBkNmwZha0UVTuJNlNmSV0iMvYk6i2I3qdLs
         4s9tr/eOjPGoRvODW8LJSJotU1rj+v/xsiyq1Q+/xLrVddkyX7/I+ahNK5U+isaDPu
         rp4E1zu4nTVNwJFRLOIhmUsg2GvSoiGfR6o7gyb4BW6PwhRdKa9kHQBFJpIchu3W65
         DbQ9VKjtBXMx9bVdSaEqI5e1B2nFzyYXAPI7lg3gpx0v+V/UJgWf/8LDfcKO/Z4l0m
         HCTXWbmWY1+GlcH863+vFtA8378z5rMGIzvbFUIG/sWrh/FZJfUAJs/1gMKeQO+CWg
         GdzYBB+copnDQ==
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6bd32d1a040so5523681b3a.3
        for <linux-wireless@vger.kernel.org>; Tue, 31 Oct 2023 02:32:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YyTJ7Jo4M/pJ6lMhOX34XD1nw+UTXlvZQg/oFxvnZZ3SuKtk1J/
        cuQJBRlazT51epSiSo/SxnLKqzsVrBhQ+w45ECk=
X-Google-Smtp-Source: AGHT+IEkP2MUggQPZMmoZUfMMyfZmPPn4GeiV9x8hi6H0QA8ftsfhJC7lsvLDOEYQmIvYau5HJZMwt5HhjQG4g5eyh4=
X-Received: by 2002:a05:6a20:4282:b0:17a:eff5:fbbd with SMTP id
 o2-20020a056a20428200b0017aeff5fbbdmr17226026pzj.43.1698744746128; Tue, 31
 Oct 2023 02:32:26 -0700 (PDT)
MIME-Version: 1.0
References: <ZPJF1/2YA4dP+ggY@ubuntu-x1> <CAGb2v657baNMPKU3QADijx7hZa=GUcSv2LEDdn6N=QQaFX8r-g@mail.gmail.com>
 <ZUAUahZakEvOXpip@do-x1extreme>
In-Reply-To: <ZUAUahZakEvOXpip@do-x1extreme>
Reply-To: wens@kernel.org
From:   Chen-Yu Tsai <wens@kernel.org>
Date:   Tue, 31 Oct 2023 17:32:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v66cVj2O89G9qhKCqca+jyBK9ic3866giL=LZX4mQo-eDg@mail.gmail.com>
Message-ID: <CAGb2v66cVj2O89G9qhKCqca+jyBK9ic3866giL=LZX4mQo-eDg@mail.gmail.com>
Subject: Re: [wireless-regdb] [ANN] wireless-regdb: master-2023-09-01
To:     Seth Forshee <sforshee@kernel.org>,
        Johannes Berg <johannes@sipsolutions.net>
Cc:     wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Oct 31, 2023 at 4:39=E2=80=AFAM Seth Forshee <sforshee@kernel.org> =
wrote:
>
> On Tue, Oct 24, 2023 at 02:23:26PM +0800, Chen-Yu Tsai wrote:
> > I'd like to take up maintainership.
>
> Thanks for volunteering! Sorry I didn't get respond sooner, this thread
> was buried kinda deep in my inbox so I didn't notice your message right
> away.
>
> > As far as I know, I would need to:
> >
> > 1. Make a clone of the repository on git.kernel.org under my own namesp=
ace.
> > 2. Generate a key pair and certificate
> > 3. Put the certificate into the kernel tree
> > 4. Update the docs to point to the new repository and certificate
> > 5. Review incoming patches and apply them
> > 6. Tag releases timely
> >
> > I'm not sure if I missed anything.
>
> That's the bulk of it. Most of the time is spend validating proposed
> changes against the government documents. There's also maintaining the
> tools to build the database and moderating the mailing list, but neither
> of those are much effort.

I managed to get some support internally for the validation part. I
should be able to lean on our WiFi team or external partners if docs
provided are insufficient.

One thing I forgot to ask. After a release is tagged, is there some
magic bot that produces a tarball and uploads it to kernel.org? Or
is that a manual process?

> Johannes will be the one who needs to accept your key into the kernel,
> so we should wait for a +1 from him at least before we really get the
> ball rolling.

+Johannes for his opinion.

Thanks!
ChenYu

> Thanks,
> Seth
