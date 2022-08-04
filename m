Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A526B58A3F2
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Aug 2022 01:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240094AbiHDXhZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 4 Aug 2022 19:37:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240005AbiHDXhX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 4 Aug 2022 19:37:23 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995067170C
        for <linux-wireless@vger.kernel.org>; Thu,  4 Aug 2022 16:37:22 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id l22so1432252wrz.7
        for <linux-wireless@vger.kernel.org>; Thu, 04 Aug 2022 16:37:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=bo2XBP67BuG05EPFv/XoJIdVEPLxa1771zsCCTAejlB5sRGBBJscipwNLbZSExpHaj
         pUyKO8j/8PL7bynEnTgIAfFfO5K7kE8SGUNCahnQkTvPNNs2NqPrlMjL+jGU6tqcn8Rr
         A/uSn/rVR5Iu09uC/vIuAEyZWqqBuJmPhdgTDpmQg7LcGzOoKz8YVbV26QOS7ffG0IIx
         8/fXPOKXG6S+ehx0Nsw5fiMFEQ4CGeFzBxo5ytpgvK6OynC4YtnkE0s+TZRo5vzbvQqY
         zpBeWRiCfpL0Ol54u9tRq0gBY0fHGFZvmHpIN8HBVco2JTUPEFgHVWy3oXKtNjGfnyiJ
         KxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=YeEFrOpnueqp49lpSsCtkyhW66cD5QzqZPU5hyS5TkM=;
        b=xIMhwvE53QHbEmI29JtgtmhQsyDl3di0Ff3ZP5BiHBSaGdYgEskC40W+qJKQ4pvbXK
         uNDyEbI+nsb7wtqf2OhVYi3ABO2OkMXqlaWyGkobuNsjgl3krgfWCkvYksjHlSkEAScs
         IuTLh3dZOG6wqjMsJizZUnb9bawmFXMFQLtO2Vh2v55zWQ0OyIuED6pwsNJ/MYU7mnlx
         0JYrxIOyqbeDz5BvrDpC2YdwYmKyGRsXjhdrzY069H6u9vBx4OTX06Pj08G56Lzqa3Pl
         StsKjN+4+m8P0zznqwdKXBTRdj8tZ3nVodnZzOMBhou37RAEeZKxnWXjjtUhVFkN2QpR
         tfiA==
X-Gm-Message-State: ACgBeo11n4SJTj8qC6zLL/jDbFXw4492J2jb4/IBvMxP2+oYZr2/X4jK
        E8hhwc3uR36qWBdXlr/FoeEagAfCSh45YgGzcjg=
X-Google-Smtp-Source: AA6agR6f0xgcbz/jJiwHDKBEx340iRt7Ax/7tcMvNnzU6SINdVNPCvSm7LlNyy11FxYItH8Y+id8uuWVtbRpODop/BY=
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr2693929wrr.617.1659656240885; Thu, 04
 Aug 2022 16:37:20 -0700 (PDT)
MIME-Version: 1.0
Sender: rasmaneniampa123@gmail.com
Received: by 2002:a5d:6d89:0:0:0:0:0 with HTTP; Thu, 4 Aug 2022 16:37:20 -0700 (PDT)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Fri, 5 Aug 2022 00:37:20 +0100
X-Google-Sender-Auth: mskJh2IMlAJTknsluuWjbZGqJ0Y
Message-ID: <CAKOWe4C3jnyGfgvXxuZShiyykXU0dpGtbmM1qCzjtEKKCyu8ZQ@mail.gmail.com>
Subject: My name is Dr Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dear,

My name is Dr Lisa Williams from the United States.I am a French and
American nationality (dual) living in the U.S and sometimes in France
for Work Purpose.

I hope you consider my friend request. I will share some of my pics
and more details about myself when I get your response.

Thanks

With love
Lisa
