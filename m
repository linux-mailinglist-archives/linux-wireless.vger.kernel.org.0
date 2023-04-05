Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5A2A6D7608
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Apr 2023 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237263AbjDEH5R (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Apr 2023 03:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237180AbjDEH5K (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Apr 2023 03:57:10 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE194ED3
        for <linux-wireless@vger.kernel.org>; Wed,  5 Apr 2023 00:57:04 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-4faef469610so236035a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 05 Apr 2023 00:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680681423;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2eIUIgQam+Znm92t75ub3SSql/5kD/CSnGjaZOIeRE=;
        b=ZFAmFQTn20XXB58Hm1LdXdWSQ5ZKxD4voHxxAhS1cKrInxf7DLRcTSbw0glAYuheNd
         QsgC19PfAnkNACoih4X9yWq8Ua2f3Z5aqpAwmyG7K5XHuwPNdYpOLvr+4dizYlmkwqvh
         8ippA6GSg6vwbKsguRd+gNlt6Q3d6qdPQH52wPe4yUNm7drYy8w79XnI6OkaMCxGYxXe
         MDkio/NlgHAyk3tGfHbZ8+FvtwIbKJyHeY9Hl3c4m/UBMxdY642/4m0lMYD1+lZcL9DU
         GTGlzj7aK8t/dfhFV0ZGCnZD6XTAnjOEHb+Mkw5/16dwcMVpicpYd4/+ImRJVe79/Ozv
         w6jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680681423;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q2eIUIgQam+Znm92t75ub3SSql/5kD/CSnGjaZOIeRE=;
        b=SGXbCC8Wgk6CevKpvGUS7R/n+HZGO9ebagnVxb2BDdKs5Ub1LrRQBIpStqUZopMFif
         iKkpo7W8WSj+4EeleGWBgKrAhCI6CqWfsnn9IP/aFSonsNWkGsYkv2Qe94bMpdu92qeP
         D0IQ5ZuaSjOTKFucOOiInMTP7ocB5yJks0LLq+XxVThCMN4WUp2LZyo1TCgdIofEjED4
         jZZubQ/sb7c0xr3ajAGNQjrPdLyUgVvZJ90NMNQax/xPW20gAglrUY5Wd+duc/IaP1/X
         3ISp/6EM4tDLoNfnMjvBKuRM3ZzmUh45tu2bqDKHC/ltLKtJGijnJesYHoEO/DJZ/qOg
         wLJg==
X-Gm-Message-State: AAQBX9fJI8SlXqc1g/oOl89RK+TI3naq9lksE/59WuA3hPgEXlR44KQS
        7LSvfEGivYig6jdZDp5Ty5vQnDzxfXfLrp9lRlQ=
X-Google-Smtp-Source: AKy350b+6mlAYsE5jCYer29QJ01MP1yshNVCPV/yu1iTNStkeOVxzQSr9n/dP8VlK7PnohYB4ysIDujVG47xryzVK58=
X-Received: by 2002:a50:d781:0:b0:500:547b:4e1b with SMTP id
 w1-20020a50d781000000b00500547b4e1bmr691870edi.6.1680681423244; Wed, 05 Apr
 2023 00:57:03 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:2202:b0:65:e547:3943 with HTTP; Wed, 5 Apr 2023
 00:57:02 -0700 (PDT)
Reply-To: tamimbinhamadalthani00@gmail.com
From:   Tamim Mohammed Taher <cisskhadidiatou890@gmail.com>
Date:   Wed, 5 Apr 2023 00:57:02 -0700
Message-ID: <CAAYY=dZe5ZjJ2b2KEkYbGOEnyScbFaaGqjvb6EmPHE7Lypp0cg@mail.gmail.com>
Subject: RE:Saudi Arabia-Inquiry about your products.!!
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.9 required=5.0 tests=DEAR_SOMETHING,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:52f listed in]
        [list.dnswl.org]
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [tamimbinhamadalthani00[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [cisskhadidiatou890[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [cisskhadidiatou890[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.7 DEAR_SOMETHING BODY: Contains 'Dear (something)'
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  2.9 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Sir/Madam,



Can you supply your products to  the government of (Saudi Arabia). We
buy in larger quantity if your company can supply please reply with
your products detail for more information.

Looking forward to hearing from you.

Thanks and Regards

 Mr.Tamim Mohammed Taher

Email:tamimbinhamadalthani00@gmail.com
