Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ED7659AFCD
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Aug 2022 20:58:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbiHTS5K (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 20 Aug 2022 14:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229854AbiHTS5J (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 20 Aug 2022 14:57:09 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4738B2184
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 11:57:07 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id j21so8976933ejs.0
        for <linux-wireless@vger.kernel.org>; Sat, 20 Aug 2022 11:57:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=2EdY+MOU1TmeQWcJcFS/IvhQ+5RhMFDPkRQk2g/H9YA=;
        b=YumCb+MuUTuf4v0pK4WdsE3MYKrIIJyid0dn8AMR7zgSD8ZQNWVeLY7NH6cqB6MXWt
         nHO+l9c7Ex6Qbtlo/bL5Q/TGUDPcYku5T9PNqdKDXCw951on4tGDxTia6GwFVcqPuN0W
         NN6uf6BNQ/pXwrUQtnIh0akx7Bscm2Lup5AdowARKj/4D7A8ydorT7AAzA7HLmFc7bCu
         g7tgr9ZfnuAFBXkmiMIJqhsKFCjFqeJRjYE20GCQuHEUzLMn1CCD5sP7WaosmGVu1cqw
         5Ep27ekhx96prsnTzNAD02IhfXAmL63JqNZW9kg74ZJ0ByKzNyQLPnAdoCYbMdAbaXma
         M69w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=2EdY+MOU1TmeQWcJcFS/IvhQ+5RhMFDPkRQk2g/H9YA=;
        b=LWQy3Kt0mHFM8kDGtgZE8BQd4DgRmxLFMTs4zro/jNqdZspHW0svmfjHnOmpmIn2+r
         zDVuSyGO1VWrZTCtdnm5PNh8Ck1YwC4AfNTgCzc88x6W7U209UXS8EUjEArDwvJ819Uv
         +ksdjHw92kSxLMh4G1v3lg0YfNcvclcSQVnGvwWFGgNsADVVm+4EppGnIM63ydk7pVel
         nqYjr+uFD5WbjFKD1Q3NmqmPBV0Yyrjioik1K2l+PZW6uKPIg9gvDVgyNHVYE4irxBlC
         nfTzrtUAIYpPH92+k5NjVexR+HaaV3e9KzeQ66QeuggDtU0dD8KLFr9GZppDZaqggF7M
         Vg6g==
X-Gm-Message-State: ACgBeo0MH3IPxnTXbJL6MsZmUqziMswtlVDDiztqVZ6JFnm6rqcw2rXj
        3VJTy18WZiL8g7sQGj3KeG1leKy7XmUhj1/7wL4=
X-Google-Smtp-Source: AA6agR7emwk6djjWhu8S/sHRAtHt9r5ZeMwYtDlHnGxQMdFfRXKXRLoXgpEd5JydhMbyoTTRWgwCTvZ8rCcr5QEB61U=
X-Received: by 2002:a17:907:d0f:b0:731:5c2:a9a5 with SMTP id
 gn15-20020a1709070d0f00b0073105c2a9a5mr8154366ejc.413.1661021825450; Sat, 20
 Aug 2022 11:57:05 -0700 (PDT)
MIME-Version: 1.0
Sender: lila.lucass112@gmail.com
Received: by 2002:a17:907:7e9e:0:0:0:0 with HTTP; Sat, 20 Aug 2022 11:57:03
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Sat, 20 Aug 2022 20:57:03 +0200
X-Google-Sender-Auth: 95eVDEykMikbnsoVc3zGw1ZZO7A
Message-ID: <CAPvtrUfDg5SAMoSrQfg5Jbw=kwXkX9yDu+XoLMBNmo7au2Q8ZQ@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dearly Beloved In Christ,

Please forgive me for stressing you with my predicaments as I directly
believe that you will be honest to fulfill my final wish before i die.

I am Mrs.Sophia Erick, and i was Diagnosed with Cancer about 2 years
ago, before i go for a surgery i have to do this by helping the
Orphanages home, Motherless babies home, less privileged and disable
citizens and widows around the world,

So If you are interested to fulfill my final wish by using the sum of
Eleven Million Dollars, to help them as I mentioned, kindly get back
to me for more information on how the fund will be transferred to your
account.

Warm Regards,
Sincerely Mrs. Sophia Erick.
