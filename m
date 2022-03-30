Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1BE74EC855
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Mar 2022 17:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348263AbiC3PfC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Mar 2022 11:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347144AbiC3PfB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Mar 2022 11:35:01 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1C343AFD
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 08:33:15 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id bh17so2806478ejb.8
        for <linux-wireless@vger.kernel.org>; Wed, 30 Mar 2022 08:33:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=k4tOjXwVcjRbwIqO75tPZMywji6NA5bvyUrV2lo9zfU=;
        b=ZvpGgO0rTRy4BxXcRwzsHHFuZRo4g3CARr5qe1cMD3fSVYBkhDQT6I2pcj7Wkus4vD
         L/pV4kO5BVuN7x61TI7A+uMRtm6324yVDgXfaYOq8q+KMQ4/V+pPoRb3AiLc/FKSr3if
         J+GN3sLdj4bXGUUPsxuj3SC4VikYaGpYroHXs5RMwPBZOrA1zUbc8rzoSnbIoyzl5VYP
         89L+v9l7lH3QmK4n4TBz8AELmkTFCPVCwiqHn4OIwiNAuuOatlSMaRsSEJOknqnFEvhk
         bDxbb6BqZPGpGeIOCUn9EPudkbn9Vuherq8IXnE6nukxV9ijFCla9WR35o8ITBwkLi59
         jHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=k4tOjXwVcjRbwIqO75tPZMywji6NA5bvyUrV2lo9zfU=;
        b=QZo+HQGGnNXTVLjdsDuM6okadvQ1ZTSnSxYbaGla06EN3j1b8WnqzK7gVOGFPPMf1m
         DPEgnHJsW2vi7chv8QgI4XWPwzsa3xvHOFvfmifxi692kCjn0ksTml3rsLSo+HsEM9r5
         B1lAAVE7aUcaHnVlGwcymsUJDphDLjEfR5ViQuLAOuRG+8Y4l5NNBPYL8AKOsvxFTXIM
         1n7NZx+xyL9lXViin0jLu+aB2jNNcDv2happiCQ7qyrT/fba6xH6MlLMMMNBPvXkHZLT
         I4s6AR72LjT7BbM6JV0SfIO50e4ahgw/HDSOoNgI+8d3Kr/TL9UGZ6BIduLrm3dR+AWV
         8OUA==
X-Gm-Message-State: AOAM530KenwWXZvs8q1Qc3yy4yP6dqm88fmPSOIskL4tQ6G9AacxIMKu
        5Pxja3hXWbxzjLph+ovIX41M0FCpqK7UApNnxzk=
X-Google-Smtp-Source: ABdhPJwqVo/RXrPoFsKPyisy5cThCgK4HiCNge6BTqyGlCrCBOuLxp78snnPGrCVRBmrldImsNzhfzIlFfVZyJBHyi0=
X-Received: by 2002:a17:907:a42a:b0:6e4:973b:9d34 with SMTP id
 sg42-20020a170907a42a00b006e4973b9d34mr102917ejc.24.1648654393947; Wed, 30
 Mar 2022 08:33:13 -0700 (PDT)
MIME-Version: 1.0
From:   Duke Abbaddon <duke.abbaddon@gmail.com>
Date:   Wed, 30 Mar 2022 16:33:09 +0100
Message-ID: <CAHpNFcPYBVg53gm_P7yh29n6ZyT=C=MsLXB5p9KyNMfZMjjMKQ@mail.gmail.com>
Subject: On the subject of PSP processors : Arm features include NEON2! Why
 not use this to our advantage? if safely potentiated! Every SiMD matters
 after all! RS
To:     submissions@vialicensing.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,PLING_QUERY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On the subject of PSP processors : Arm features include NEON2!
Why not use this to our advantage? if safely potentiated! Every SiMD
matters after all,

Particularly preparing for the GPU & Audio output!
As a driver specific the advantages are around 13% improved
performance & 20% improved code flexibility on SiMD compatibility.

We can also directly utilize for Automated Direct Reactive Secure DMA or ADRSDMA

(signed RS)

ARM Patches 3 arte enabled! https://lkml.org/lkml/2022/3/30/977

*

GPRS for immediate use in all SFR SIM's & SFR Firmware & routers &
boxes including ADSL & Fibre

Cloudflare Kernels & VM linux, I pretty obviously would like to be
able to utilise cloudflare Kernel & Linux & cloudflare is very special
to me

Submissions for review

RS

https://drive.google.com/drive/folders/1X5fUvsXkvBU6td78uq3EdEUJ_S6iUplA?usp=sharing

https://lore.kernel.org/lkml/20220329164117.1449-1-mario.limonciello@amd.com/
