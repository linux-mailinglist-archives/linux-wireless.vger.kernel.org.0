Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40B5E6BE2A1
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Mar 2023 09:07:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCQIHL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 17 Mar 2023 04:07:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbjCQIGe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 17 Mar 2023 04:06:34 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F4CBAD0D
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 01:05:12 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id v25so154685wra.12
        for <linux-wireless@vger.kernel.org>; Fri, 17 Mar 2023 01:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=stapelberg.ch; s=google; t=1679040308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RdFAbNxeioSYumhW/hAfQVsQRlrPL05CrJULmrCvwxo=;
        b=K7aJAR1zPKRyuSV0kUEpKQLTN1549ZTFTugUXzeTMK1yztgLTWdtsap9SfM73mtqLZ
         UZ79xq3XmhdmLmRYYI++LFuEtsfGokSRc/pDb6xfAz9BO3mLix3VVLVPTBQtNIlVig0H
         DbFPKCBUTVrvnnWkUJIVyBcveqxomQZ1SLJydW13pthx68X3tGjteJKdhDSuxGHXpdgb
         gaUKDxyvAO7OUesOLcCW5GQDf52hS99jAjCLsluR/I/Mef/E2eRLUgVlFSBYN71gdsxZ
         awckOIggVt07oBaFSZpr/rmhD9XYm3WBF7RQF1eE/2Xhk9/p9hQirxeBbgccyHOGxoS7
         3kGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679040308;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RdFAbNxeioSYumhW/hAfQVsQRlrPL05CrJULmrCvwxo=;
        b=j9IJsK+Q7c71anbrS6CJ2KkX+iRSyD2dWZ4d9w5KpRzJmkWHCmKWJErxBJvsp6atg0
         6HTuxbWAUsXqntG+jbqqSCrLdZFOsSuCyapWiY3p7cQ5bwN9ALGWLa1pYfM0s7pKrCFd
         G37xc4ZW6SZT8fVePqvpY0RCAIP/shTPQwGO//vhW/9SthXitEhYKL68yz5hfH0yFqXL
         uhKA0+rz+baRx5KkU29nj6HmtgM4J7c8QYXrcHVA1/XfuuO777/9GvShsnpuZXKJbdxl
         0TzGtMviqRx8Vt2XebM0a35fF1Fvjmt48L7WioPmoLSVN3PEWDT2YxNjrMGFJXFdHweX
         8xSQ==
X-Gm-Message-State: AO0yUKX3J8g/1e2SDB9OJjnxsGD5I2SvgjxrG9Khjaf2hjSeuTh+tB4+
        ZSmvoB7nxQwv3yMro2rXtqlEtJVYq9CgkN34tzC65Q==
X-Google-Smtp-Source: AK7set8+8jF6ORDQulCi7tdduGiUvxXelEWC7Wu4SyS7TL7bCjTiv8RGYElMJXsUkOQPwVKMZ0TBMhulhC1pksszhOQ=
X-Received: by 2002:adf:e445:0:b0:2ce:92af:43eb with SMTP id
 t5-20020adfe445000000b002ce92af43ebmr1905085wrm.0.1679040307884; Fri, 17 Mar
 2023 01:05:07 -0700 (PDT)
MIME-Version: 1.0
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
 <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com>
 <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
 <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kaGj1SVCqf2y3=Xj_N2G9j+-VhLDN4_WY_ywDswNkO3g@mail.gmail.com>
 <89262772-7358-77e8-8913-c459819d544a@broadcom.com> <a459b9adc5eb7b67a432bd947d47d1df08718762.camel@sipsolutions.net>
 <f430c376-5992-d394-ce55-5994c793c7c7@broadcom.com> <CANnVG6neOX+Bgc3zWA8k=hwrifmXb=xBN95aMUEyJ=orz3+Wkg@mail.gmail.com>
 <186e9109ae8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kvP78+WADH+Z4Yk4k9m-rjwRw0qMprHNsngNaj-jpqJQ@mail.gmail.com> <20fc4c19-6f39-d3bf-b873-ea26a26175cd@broadcom.com>
In-Reply-To: <20fc4c19-6f39-d3bf-b873-ea26a26175cd@broadcom.com>
From:   Michael Stapelberg <michael+lkml@stapelberg.ch>
Date:   Fri, 17 Mar 2023 09:04:52 +0100
Message-ID: <CANnVG6m2re0AmZB8WTbGfNyWA0dy0KEx+nvidGsQ=E2LP0wsnQ@mail.gmail.com>
Subject: Re: wifi breakage due to commit "wifi: brcmfmac: add support for
 vendor-specific firmware api"
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Can you outline under what conditions the race can happen?

I=E2=80=99ll take care of implementing a userspace modprobe helper.

Thanks


On Thu, 16 Mar 2023 at 10:40, Arend van Spriel
<arend.vanspriel@broadcom.com> wrote:
>
> On 3/16/2023 8:54 AM, Michael Stapelberg wrote:
> > Hmm, I=E2=80=99m not sure either.
>
> Actually, the check I referred to only bails out when
> CONFIG_MODPROBE_PATH is unset. In your case it is set but it is not
> existing. I dived into request_module() and it ends up scheduling a work
> to call the modprobe which will fail. However, brcmfmac will wait for
> brcmfmac-wcc to register itself so doing the insmod of brcmfmac-wcc will
> do the trick. However, now I am back at saying this can be racy. It
> would be better to come up with a modprobe.go for your user-space
> environment and put that in kernel config.
>
> Regards,
> Arend
>
