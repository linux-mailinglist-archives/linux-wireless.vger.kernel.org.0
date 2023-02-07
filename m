Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C568DF9F
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Feb 2023 19:12:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231272AbjBGSMO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 7 Feb 2023 13:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjBGSMN (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 7 Feb 2023 13:12:13 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BDE313D44
        for <linux-wireless@vger.kernel.org>; Tue,  7 Feb 2023 10:12:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id p26so44709241ejx.13
        for <linux-wireless@vger.kernel.org>; Tue, 07 Feb 2023 10:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=Oi3R4zoiPlz+fMNusXKiWVXFC2bfv6LENlE2PWSgmGSL4+9N/Neyzkq7D7rl1Y6HPo
         +4e3gsB+GWCmLxxX5SOv2+n8yD1H/hFeGoViXIsqEGBBq/w1VO/RdbOnyuNdiNNNe4bU
         pxIaqAT0YnYOQe4yJK2Gyu4YDZP9OOyYec3PyI9EmQfRPnEXhmJbaOKlrOpIlYGSm05q
         64aZXK6fK2VqQqupi3+xoLn8+a6ovDcI0p/StqmYcT8PksDIz8GObWCdKsHlcN5a+bJN
         RczbAF5hvaUoei8oxV+YhzJGjiTsKXgJjvW6+27BEvCNkAR9RIj3Axh+4RE0HUqcKRDo
         /aBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/rL+TycpMQLfB5P4Zn9xgGfUWg8yPCNTwrE46ZNldMM=;
        b=TKxWxIT1vAS+Jm9KD4fiPZUN4ldXc+1pn53tRHKnX/XnRj3o4iM7wYEKXiQMTzA566
         UtsvYKlFIVCRdKGI+S0Sx7OlHMCjQP9mo8P4HMapKVrHHNNHfVVA1IjtcIdMnLtjSerJ
         +fE2qn1dO2vfC2lXzBbWw0N5fODJ4+cOfiEhfu5avlyUyfte9jZDfjUGPfcxK/J0qKpu
         yRcakyz8IW8bjREYQC5wq/wdzQRQPG3gfC+Ncklb7b+21UI5yQbpDORN4lB0T96NJqoO
         w/krkW0ms0qw/NeElwHI3jdlrUrSFM496kmzHtEIfXgnSuBfKuG6z5A+ZEo4AFvRry+I
         VDig==
X-Gm-Message-State: AO0yUKV7CeK3eEnc1AYQECyRcR41i/DnqstItecHhiMMyTHaA2qjBaHc
        B7giQcuE0+6g2WHHOQNi9cltqaZVHf02gHMtJl4=
X-Google-Smtp-Source: AK7set9aMe79qtuKS+exWaaUJ0SaCJHhfLLpUxMpoHTK1ceZaRCYoE5k//nCmLc8Q0stONSXIZQRU2Qs7/hN0MoC0lc=
X-Received: by 2002:a17:906:d0cc:b0:887:9adb:da53 with SMTP id
 bq12-20020a170906d0cc00b008879adbda53mr857266ejb.166.1675793530863; Tue, 07
 Feb 2023 10:12:10 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:640c:f88:b0:1a5:7bad:2559 with HTTP; Tue, 7 Feb 2023
 10:12:10 -0800 (PST)
Reply-To: dravasmith27@gmail.com
From:   Dr Ava Smith <harikunda1116@gmail.com>
Date:   Tue, 7 Feb 2023 10:12:10 -0800
Message-ID: <CAGEpkWqK+40u87mxdK+88B11WWWaxO36i6Ga7Mymwe=5y3tPVw@mail.gmail.com>
Subject: GREETINGS FROM DR AVA SMITH
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,UNDISC_FREEM
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:62f listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5133]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [harikunda1116[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [harikunda1116[at]gmail.com]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [dravasmith27[at]gmail.com]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

-- 
Hello Dear,
how are you today?hope you are fine
My name is Dr Ava Smith ,Am an English and French nationalities.
I will give you pictures and more details about me as soon as i hear from you
Thanks
Ava
