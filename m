Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66984C2339
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Feb 2022 06:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229939AbiBXFKs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 24 Feb 2022 00:10:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiBXFKs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 24 Feb 2022 00:10:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F13E3165C26
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 21:10:18 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id d3so1187865wrf.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Feb 2022 21:10:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:mime-version:content-transfer-encoding
         :content-description:subject:to:from:date:reply-to;
        bh=RJ68TeqInk+TVbxgDvO8h5StnFiK/1aAUXR3+oOBLqU=;
        b=CDUuRmXnMQi0b0JYlr4wyNGjVbaFyOunF9n/PuGtfrFmY/mmjwuxv+8alXI2YJ+a6D
         +nid6s5RolNI1Y+L26+IRSpwzo2F44htNGdg/bi4UppyinvcgUKamTqmebG82LbYSsYh
         semsVrVIGq0oTZXUI6BF5lLTw9yTOz3g4EzPoiJGynvCcJRjE+e9s4CATdNzrdbMC6DS
         aO4D/tbAWewLfyIAmS7tG5l8YhlTtDhkOmYPa27VDiCopyvygdRmYMrNxbau8qXmKDrg
         VX1PVWf8t/eVyQGK9k3aabsdK8bUJqn/+eIKS5c1otiOaS7QznughyVFtaVUswJO/GAm
         m5MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:mime-version
         :content-transfer-encoding:content-description:subject:to:from:date
         :reply-to;
        bh=RJ68TeqInk+TVbxgDvO8h5StnFiK/1aAUXR3+oOBLqU=;
        b=rfVDggajouT34gWMDR3az6ToRW/kYSSxWYq8KPYorJjBgt1uiOXng+2xSlLCvkKvlw
         p5C8y0Dn1CypE72jOc6vX1gmnXlckub5LB6Fyw9qSWOKOcacN2GR/hR5HzmYeYUCjeOU
         /BuWpNmgTVzt0cnh5esgQ7iU86ZINpzV2eKui6X0+l9PhG081AgqyC85WiOfc2BSLjLO
         GGocRSGicxPWos5aRjz4t8cUHTqV95VNU0MLQ0C+sojb+yHdSzYRTu9IRdCGftYSiqUw
         jD02WJVxQuhaEpNXpZrHQly7ajUQaZ3MyQe1crYBXgc87/yRMJbSqv3K4nJJ4XjcHHlv
         rFGw==
X-Gm-Message-State: AOAM533rJChtWHsZZjScVBGEfiHOZB1MNlzlrE1eZKiijtugpEraQrWg
        /xT4Pxc+ADjJdXX6jgkH8j8=
X-Google-Smtp-Source: ABdhPJyhcoihujZKUp1YR+Ilw8dWUnPSUfWpooMVJ8R6ffZ3W3QYtpPlJGegOoqaV3RyisAcLSb9Xg==
X-Received: by 2002:a05:6000:8f:b0:1ed:bb0e:6cbe with SMTP id m15-20020a056000008f00b001edbb0e6cbemr730199wrx.209.1645679417544;
        Wed, 23 Feb 2022 21:10:17 -0800 (PST)
Received: from [192.168.0.18] ([47.62.107.23])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05600c1e1e00b0037fa9762d50sm1669151wmb.12.2022.02.23.21.10.16
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Wed, 23 Feb 2022 21:10:17 -0800 (PST)
Message-ID: <62171339.1c69fb81.e312e.6218@mx.google.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: UNCLAIMED PAYMENT
To:     Recipients <michaelandrnic@gmail.com>
From:   michaelandrnic@gmail.com
Date:   Thu, 24 Feb 2022 06:10:15 +0100
Reply-To: masayohara21@aol.com
X-Antivirus: AVG (VPS 220223-4, 23/2/2022), Outbound message
X-Antivirus-Status: Clean
X-Spam-Status: Yes, score=5.8 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        FREEMAIL_REPLYTO_END_DIGIT,RCVD_IN_DNSWL_NONE,REPTO_419_FRAUD_AOL,
        SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,T_SCC_BODY_TEXT_LINE,
        UNCLAIMED_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:431 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4992]
        *  1.0 REPTO_419_FRAUD_AOL Reply-To is known advance fee fraud
        *      collector mailbox
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [masayohara21[at]aol.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [michaelandrnic[at]gmail.com]
        *  0.5 SUBJ_ALL_CAPS Subject is all capitals
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  2.4 UNCLAIMED_MONEY BODY: People just leave money laying around
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

UNCLAIMED PAYMENT
You have pending funds on your SURENAME. kindly connect with masayohara001@=
gmail.com
 for details

-- 
This email has been checked for viruses by AVG.
https://www.avg.com

