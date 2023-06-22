Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3735473A6FD
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jun 2023 19:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjFVRLQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jun 2023 13:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjFVRLP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jun 2023 13:11:15 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1566EC3
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 10:11:14 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id 38308e7fff4ca-2b1b1dd208dso18608891fa.0
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jun 2023 10:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687453872; x=1690045872;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yhjBhVUq/JtHVeGH7sBlCcMZ4AP8+/yjN6oOKRTIC/0=;
        b=kD1ZEF8/GCvNj/XZ3QU42JWHo4FOIsrr7c40rcIxlfNywVFHmFvtzsP5h+0Z7QoHYC
         hz09RZB3uk8nU3I00kl36o/l2iulb1vIWW4MTDGnxVud6IAM/+cBwaZFnvd6BkHv0fNg
         ZSx7iUTse2KLZb0FaAaySqu+B/zCC7yFZ6pMY7KwztjjruKTrqHWFefQvZIaWggeMzC7
         /tZuz/NBkUUIladGBjuXLfT26oS6/nid1UIhg2j1fgX+QDvIaXCnfUNhinHb9rXbOwaw
         /pY7AgIJGz081a0m6ayLvmPiLO4EZv5OLX7Vm2y4MoREfMs5HUd6uAkUCgtxVStK4CjG
         ZE7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687453872; x=1690045872;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yhjBhVUq/JtHVeGH7sBlCcMZ4AP8+/yjN6oOKRTIC/0=;
        b=fbOKptvVqH7uUeiQBo1mPYiSC0w7yujRD5iU1OCkpAR9Ry6Lsy7qkzVAQiUA76H++/
         I1zUHPg1vYsnZrL5Cqe6CyCDT6/UAenjg0X//gQx2Fmu+txSocQroo32vDRAAvzPdvEC
         vNF4hmc5WhOIkhu/68d3lUR3ByP5FWhhdk7Rt4Won+fuevWLfezVv1Gp9YmaCszEun7i
         alOKGPeF9zl5qeW0kyYKRnRvilFTsdx/p1ypew1CNarq+nETCdl0eUjBazn5Gam8W0Ox
         Q9j8qMuntYOSCTF5cJtBHEa1Se/LcdrC/x9K4Q1FNaSvJpJACgjAIpOWdHp9CJPhHtd2
         dLjQ==
X-Gm-Message-State: AC+VfDxv4Mv3m4hPcvMo5tb9lEO786fMm9SvfAeUU1HFsYUhXlQVNukl
        O/5Xaw6OA47iB+BZCqIsBJRwpzpC/6PMErfJn2Zm+fkM
X-Google-Smtp-Source: ACHHUZ7mZkFTsMPmY9LuxOQkzZIjsBIp980nUKYoXQOhZybGVvBihzq7/yomwizhCrC7E8L6bHavdvHPNIv2C7PmYWY=
X-Received: by 2002:a05:6512:25a:b0:4f7:6a87:f16f with SMTP id
 b26-20020a056512025a00b004f76a87f16fmr9069371lfo.4.1687453872162; Thu, 22 Jun
 2023 10:11:12 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab3:568c:0:b0:233:6552:fda3 with HTTP; Thu, 22 Jun 2023
 10:11:11 -0700 (PDT)
From:   Tom Psyborg <pozega.tomislav@gmail.com>
Date:   Thu, 22 Jun 2023 19:11:11 +0200
Message-ID: <CAKR_QVJ2Ho66tuSJ3Vuh6jmbifMSBSFB0L7_Ma7sRmHyMk4DHg@mail.gmail.com>
Subject: 
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,TVD_SPACE_RATIO,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

unsubscribe linux-wireless
