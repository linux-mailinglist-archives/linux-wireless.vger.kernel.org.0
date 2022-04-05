Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D98AF4F21C3
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Apr 2022 06:09:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbiDEDLm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Apr 2022 23:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231482AbiDEDL1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Apr 2022 23:11:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 664C2140EB
        for <linux-wireless@vger.kernel.org>; Mon,  4 Apr 2022 20:03:17 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id o20so4038404pla.13
        for <linux-wireless@vger.kernel.org>; Mon, 04 Apr 2022 20:03:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=QIV74h+ksSLMqZM4vSiU78U364uH43VkZJFlZQMUtBU=;
        b=K45Bxv59an5fVjW6keOrUro1TI+B8229YHWDiNqcKOuMCiBFue1DMskUfabUrkRrNo
         Zoxhlr8Aj+k1lAWI6IjoZcAGi1u5o9enPFnw7dvSvmSNf6RUzESdxqQURKDyZYeUIASE
         u+HJLNOizDscunk3sKXzVqhWPMlxlb06CBShhQOKclt0E84eW7Qp0O/iwZPxyD27yWWq
         q6B8zTWhWQQM1Xt3d3QxY2hxRa5IEBhhIEwRF1hlrwS7jPe6zWLo+oh7zkMVQc4aydAJ
         p72bKaH80gvJBtHHwb4X9Ata13gJiU9Ba+XVHfpPaHg6ElAe6EZOoe6zp36AdZHPry6M
         vMPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=QIV74h+ksSLMqZM4vSiU78U364uH43VkZJFlZQMUtBU=;
        b=hX7sP+1t1/k6IiV15NAfaAoLUaWAPJpZR6EJLFPRQvDA4038ItE4osNcbXsx1nmomS
         FCizczFf68h+S/fmUxy/fSbJLXbK/BQxr/AM+74Lg/tG0v1Y4czvfA9/yzZfVaLnNgPN
         4VmH8v6ZaYuOrB8XfC1PC/0s2CYO9II3WawxFdysLC//+plRwsu72DUNNS+62Lya+CwD
         T97mqxszFcP3ZWt8mRl6lOIASnYO8n+hWyn7N04YSmzhLTe1BfkmbQFfMIhPyB5/8xOX
         z0mrZc7zEXB3bnh+UjRlwOfvOJpiyoGWI/vH64v7nwsyqk/lTeT4+TWRMxc9JDcGj0q9
         JRAA==
X-Gm-Message-State: AOAM53006AZXazfBBIzCFqyM4eIUoPlFolzrCs6e+0kV9xpl+OYIovIN
        mPubr8ZlEqWM8brWD+mXus5+JRLOaV5rdmt4SE0WweUA
X-Google-Smtp-Source: ABdhPJxsYOwtmd+VRGlvjfo6/XUDPII7uagJVj1iMZOE1zGlT6VFVZNBlVPlEPuTqJRUmJY2n2cGnr2QcNpYOATco8U=
X-Received: by 2002:a17:90a:380f:b0:1bd:4aa6:651 with SMTP id
 w15-20020a17090a380f00b001bd4aa60651mr1519747pjb.83.1649127796929; Mon, 04
 Apr 2022 20:03:16 -0700 (PDT)
MIME-Version: 1.0
From:   Jupiter <jupiter.hce@gmail.com>
Date:   Tue, 5 Apr 2022 13:02:40 +1000
Message-ID: <CAA=hcWQFNOeycXFPhrtHcQG3V8fWSShNRuAi49jtv8h1fPVUuQ@mail.gmail.com>
Subject: Support for bcm43364 wireless chipset in brcm80211/brcmfmac
To:     "David S. Miller" <davem@davemloft.net>,
        Sean Lanigan <sean@lano.id.au>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi David and Sean,

I am considering using the Murata WiFi module LBWA1KL1FX which is
based on the CYW43364 / Broadcom BCM43364 Chipset.

Our design criteria is that it must be supported by mainline Linux.
Searching kernel log file to find that you added bcm43364 wireless
chipset to broadcom/brcm80211/brcmfmac driver, could you please advise
how stable and reliable to run brcm80211/brcmfmac for CYW43364 /
Broadcom BCM43364 Chipset?

In addition to add CONFIG_BRCMFMAC and CONFIG_BRCMFMAC_SDIO, should I
also add   CONFIG_BRCMFMAC_PROTO_MSGBUF, CONFIG_DMI,
CONFIG_BRCMFMAC_PROTO_BCDC and CONFIG_OF?

Thank you very much.

Kind regards,

Jupiter
