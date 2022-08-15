Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6772559334C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 18:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbiHOQc4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 Aug 2022 12:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbiHOQcz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 Aug 2022 12:32:55 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2E3D1704B
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 09:32:54 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-31f661b3f89so85706787b3.11
        for <linux-wireless@vger.kernel.org>; Mon, 15 Aug 2022 09:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=nHtY/kfAASxM/yBQE+FWm+dR1lD5RcqE0eO6UIVa5ewWXWFLYL8k8Mo+YqHLqMeAoE
         SgW5tNg+5aIbX3J0k+uu3PyU6JgTcAL/RUlutfFaskSG9qyHdKB8Dn1W8V/kxsgvTAGa
         ejXbhO7QndCz4+bUXVB/ZY2QM3+6bEKFMukbVMhWO/z/oZX7jnk0+S341n/I2XRN7ifR
         6TtpcfvZoiVwc1XdNx/ALugyF3Nfs/DozJLgALPCgImVMoaIVzZld+iYkBCPwBAHWFFi
         3qy+uu9EkLdHG059Bx1MXkof7Z3b8uv3NGrsYmqzu5POwnIL7pmbxrkuuq2+50u31/GS
         Oybg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
        b=i5GlJ48R0gT98WLF6g+VyU+1oWB1wQLYn1AB1Q/Ojwgfr72PMtZ4R2375zWJSFSD5f
         Iz+rm7cy8fXtnfi/nLZBFS/FM40nbFUPvSBMJCFPlzl7Cz7fTFwnVYvx4JcSKKVOKJZd
         6LGQyuiOe1MFFHeljtc6ugzVnq3NQH/oOl8D6RvTzA5pwD12acugoe3U0poKpHg/vTk/
         S/+CKhBfp/Ro0hTTXhOQL8bPCICRTO0WX+8Y9tqFCYJpdFNJDWb6Z3Y55cZDbMVd5D5L
         QFwY2CwciQAFb5qQlkK0s7bngPOfEGMAX5ll3rMrhaN9uqTxq/2D9w98bqx8kYw7k3RD
         K0LQ==
X-Gm-Message-State: ACgBeo0WePaYBnUfipAMe8831J6TAcCcvHUcRy2LxYDqmHaw05NKETzt
        Qrc/6a787OTrnA3texuRXn6RFdxDVeVBecYX1VU=
X-Google-Smtp-Source: AA6agR5mxJjotp7y9zNBAjq8Z0JWVz2etij++W3V91TUrHK6n8hnCceOc64ZYFIymewIYvtxHtzi5Wk/IL+R9kMO5sE=
X-Received: by 2002:a25:d0c:0:b0:687:d754:28d0 with SMTP id
 12-20020a250d0c000000b00687d75428d0mr5462235ybn.206.1660581173862; Mon, 15
 Aug 2022 09:32:53 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6919:258a:b0:ce:9327:4617 with HTTP; Mon, 15 Aug 2022
 09:32:53 -0700 (PDT)
Reply-To: kl145177@gmail.com
From:   Ken Lawson <tannermichael605@gmail.com>
Date:   Mon, 15 Aug 2022 16:32:53 +0000
Message-ID: <CA+DEpxkWhqq6tu5pvK+Nq3Cq5yq_00ZqJ20hy2Rvo0GyRdOK1Q@mail.gmail.com>
Subject: Did you receive the email I sent for you yesterday morning,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:1135 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.4995]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [kl145177[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [tannermichael605[at]gmail.com]
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [tannermichael605[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


