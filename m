Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D1382CEBF2
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Dec 2020 11:15:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728157AbgLDKO4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 4 Dec 2020 05:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726330AbgLDKOz (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 4 Dec 2020 05:14:55 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D88C0613D1
        for <linux-wireless@vger.kernel.org>; Fri,  4 Dec 2020 02:14:15 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id ga15so7900114ejb.4
        for <linux-wireless@vger.kernel.org>; Fri, 04 Dec 2020 02:14:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=oaDQ6zSTJ4ub1aPJZPTUCYeVtGcde/rV3HJcksaJ4Ao=;
        b=n15vwYJX19hGObxRLU26/oSyCXjXycLWdDXjRuDxzblOokDDmktqSxtoVoWi++yT3K
         naVuDOED0sgZfOMsaViiXm4ma8uEN7PdcH/LqHg33D3OcwBbp8mFeV+zLzDnMVHygman
         c7/SA7R8QAPjA9JCSyo0+9fiIBU4tnFle/6OW2lODT8x0ZAlotMJFWT2AAbG/6m3EtoS
         AFnVvMrpwHpqIdzDot8QhWClbaYBVYDt5toEhuG7aTV0JCQGTtEJdgVKRaxX6doc/Ixf
         Z6xyCUCrbvdIh5fNJkhKx7FGbE3240wk4XHZYe2nMi/9URntfMsAUs8Gfw5JomC8Ca1T
         s/zQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=oaDQ6zSTJ4ub1aPJZPTUCYeVtGcde/rV3HJcksaJ4Ao=;
        b=SrmRTa729H9bz2wy0adgWK9C4lRPTQER/i8cf/ms4sa8syG5ZCGEH0fXErUMUStaFf
         +KDI8wQROfz7vjd/kp+K6U8eRNssOlLInW4uNJjxo62qJNJHzLfJUE4cih4fuKja9yn2
         /tdefCOXwUDJQml9J+1d/5gzrAxrvHh6btLeHQOjY4jk7PO+VCt4TCvHPGx9yYtLxxSH
         p6kPzpKdBgXx9uTm01uBFSmz7zTnAOzj6gZsCSNfugq1QkjaCC80Vgl7AUNQPsW0PbWW
         Wvsr6B8PRhsoFYQNFqQtSQk3LoXJFRNBSKCGQ5nWKUGw19e3H1i0tfP+llTuBtJLwFo5
         5zxg==
X-Gm-Message-State: AOAM5336QTMl6O/y2Cg7oGVbtUl6pkHAWA3EcMBsleDyRTpm2pM2r5Eu
        MNmg4uUMReyaJ/njBW+jSb4STXouDON9ACp2jiFBU9OEgd0=
X-Google-Smtp-Source: ABdhPJwpVFBv2c43+8MPb4qpoIR2kez7qD6u07+l9xzXqo9uAlnpZdyuwXja8aWDEmrCEARCIdlCYKBKM6lRZbWUsEA=
X-Received: by 2002:a17:906:3153:: with SMTP id e19mr6689294eje.17.1607076853883;
 Fri, 04 Dec 2020 02:14:13 -0800 (PST)
MIME-Version: 1.0
From:   sdnlabs Janakaraj <wsuprabhu@gmail.com>
Date:   Fri, 4 Dec 2020 05:14:02 -0500
Message-ID: <CAPWex-ALBO21-xwc7fRr5aS3r2bwA7W+c09Oz1zvL1Z_i9DS=A@mail.gmail.com>
Subject: Wmediumd
To:     linux-wireless <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,
I am trying to use Wmediumd module from the repo
https://github.com/bcopeland/wmediumd. Compilation and installation
were successful without any errors.

I noticed that Wmediumd crashed while running tests/interference.sh
script. I tested this version on multiple Ubuntu flavors and kernel
versions 4.18 & 5.4. All the machine have the same issue.

Any leads on the same is much appreciated.




~ Prabhu
