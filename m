Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59AF7F38C
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2019 11:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726648AbfD3J5g (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Apr 2019 05:57:36 -0400
Received: from mail-it1-f195.google.com ([209.85.166.195]:51857 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726262AbfD3J5f (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Apr 2019 05:57:35 -0400
Received: by mail-it1-f195.google.com with SMTP id s3so3719155itk.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2019 02:57:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qHpnkmbK4R5KSOMHAVkazB8fXUjqKbNz22rglVCB3ic=;
        b=bNTqmU0p6cepQbwR8kTM3X9wGMzdMpbaRlfVkJtc3l6CVG1akqnizIf1b8WRAL+/Iu
         ZeClIq24ic+EMs+WbpZPFZ8OsdREKhQL1DY8KIU+p4k/kZx2EmYWza5E0pKt8f+jihDn
         jQl9imrwIUI0meXe4zdBntor3GEpCNxH3JMKwwsIqDolwq5ncRmTXkQEuM6PzBq1YiMh
         E3Dc77zfFlUENbSurqS9qXlaDYH6VP4Qi6GPuGrT2LE4ZPhG1MI9gpnfAALKfFWE+Nh/
         ZHzDcPoFQY0EJ4S4YhusfJaZ1ya4Yo8V44nRtxnTx85aDRDsmnO2ynGFOweHioz1F8Wv
         oYrg==
X-Gm-Message-State: APjAAAUT4HGc7/sd4qA4FBtqlQFAlgd30iI5n5ostXBkNjJnTjFbvtM8
        yCQH2mGjlb/whk33mrlP9BC90iyFLnTuVvixB5m1hVus
X-Google-Smtp-Source: APXvYqxUr9Lxxfp8TE5kW9JRyrA08OdRsEDRwL219b+IVgr+dZ6CPYrxvfVEftz1rgqL68T/zjy8I2yHggAe7G4rLn8=
X-Received: by 2002:a24:40c5:: with SMTP id n188mr3178592ita.68.1556618255156;
 Tue, 30 Apr 2019 02:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556525110.git.lorenzo@kernel.org> <ad6f286f30e8d9080320164a5551c2ee37bd6a95.1556525110.git.lorenzo@kernel.org>
 <2c1357f9-95e6-49a2-7a75-7c2d6c89203a@nbd.name>
In-Reply-To: <2c1357f9-95e6-49a2-7a75-7c2d6c89203a@nbd.name>
From:   Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
Date:   Tue, 30 Apr 2019 11:57:24 +0200
Message-ID: <CAJ0CqmVDOCNpfFT06HVYL8maUmK_CxvH6GwggEbRJ7J+nLxbsw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] mt76: mt7603: enable/disable pre_tbtt_tasklet in mt7603_set_channel
To:     Felix Fietkau <nbd@nbd.name>
Cc:     Lorenzo Bianconi <lorenzo@kernel.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Stanislaw Gruszka <sgruszka@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

>
> On 2019-04-29 10:13, Lorenzo Bianconi wrote:
> > Disable pre_tbtt_tasklet tasklet before setting the operating channel.
> > Enable/disable beacon_timer in mt7603_set_channel
> >
> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
> This doesn't seem right to me - I don't think we should send beacons
> while off-channel.

Yes, right. I will rework this patch and even patch 1/5

Regards,
Lorenzo

>
> - Felix
