Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9030F2C848D
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Nov 2020 13:59:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726361AbgK3M6Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Nov 2020 07:58:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbgK3M6Y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Nov 2020 07:58:24 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7B00C0613CF
        for <linux-wireless@vger.kernel.org>; Mon, 30 Nov 2020 04:57:43 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id 38so8659676edr.8
        for <linux-wireless@vger.kernel.org>; Mon, 30 Nov 2020 04:57:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=TO8jXnDQ8FgpfW+P/dRD26QaCrrbF7pQvwN4halDR2c=;
        b=O4wPICY7zDMKSYAP3U+z59/YQ+rokf+tsRLucbp02LxmWL4k6APwhWoOYw1XEW494Y
         GYvYuCWLDcrkyw0zGhq36/PcECLox/bLjxDza/9snbDbl+nV7+sqOT+w0KpjK7sBBnkp
         uos+KZ8d4e0+H6yRfiv5Sy6YqTvWhIp5cj/L86yPertN11OQHqQ7govjATb4Lrs9LD1u
         Zw7EEaTzZT507q8qkpSNdtTALK0XNihdMmX2YMTK5+gQ8D3CjPryy9QU83/pspq8MMtQ
         bxVtbqDbt5jtEXhXTfoJVA1VVL3HgPo3bvA0SqotR5/VgyH6QHrn5efFyvrVciAHeQHH
         RrcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=TO8jXnDQ8FgpfW+P/dRD26QaCrrbF7pQvwN4halDR2c=;
        b=oxteSlQlYF4nBnP3IK3E3nJ8kR7COftllP9/+edJCl3uShoY5qMD6xXEtcyHlly/Z+
         4/rnowmkaSQivh9Iobxxe6m4h6P4t3JYSOVN/ifAcEzS5a8KgUg7X0D87v5XI5RdMUxZ
         9S80umG0nITJzi3s5OQK/GCQC1FjuoECbRlxRCmczSoydX+hosZa/oxkg8y1CdDQUvSv
         2PIp1F/oXIS3mrVDAncMIt0if3TVgVAMBCBfTE/SnS1QzLvCjBOScE4IlfdRzxRsBlGJ
         iWWNzLc9UtuvKnaOwzJelbiJVprYPGbpHfqIiq7AymQZxInrkg9V/V1LJ5ZKQ/bWrYGk
         Sx/w==
X-Gm-Message-State: AOAM532xWx5f+PxZjVivTZGu/sbs2EULnpKVwUD6oJLUbOmH477JFu4+
        Px8rlXOm3kIzrnTJmpt8R6XzgQ25CM1/Lo3v1WqNbOMApsA=
X-Google-Smtp-Source: ABdhPJy1U5wrDmTfwQ4+QJXRRvltcpTj0WeE/aCdkwxTZdlECBjLTor8aiZupAo+HBFPeC+HMm+K/Bn+KTmSohaMQxk=
X-Received: by 2002:a50:b404:: with SMTP id b4mr21453583edh.369.1606741060988;
 Mon, 30 Nov 2020 04:57:40 -0800 (PST)
MIME-Version: 1.0
From:   Menion <menion@gmail.com>
Date:   Mon, 30 Nov 2020 13:57:34 +0100
Message-ID: <CAJVZm6foDkE=Y2gxjYrjd-Rk3mkANUC95S0ND2s41uwEhvtf=w@mail.gmail.com>
Subject: MT7612U WiFi USB dongle that start ad CDROM (contain Windows driver)
To:     linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all

I have just received a chinese USB dongle based on Mediatek MT7612U
that is quite particular...

When plugged in it starts with VID_0E8D&PID_2870 showing itself as a
SCSI CDROM, which can be mounted and contains the windows driver. In
windows, once you install such driver, it switches to the well known
VID_0E8D&PID_7612 detected as a Mediatek adapter and working ok.

In Linux of course it remains stuck at the "CDROM mode".

Is it something known at mt76 development and that can be managed?
