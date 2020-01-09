Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 774E7135D2E
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Jan 2020 16:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732543AbgAIPr0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Jan 2020 10:47:26 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:33104 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731177AbgAIPr0 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Jan 2020 10:47:26 -0500
Received: by mail-wm1-f65.google.com with SMTP id d139so2345561wmd.0;
        Thu, 09 Jan 2020 07:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=CSAMl7EJyJdjDOiZuTQVDV1QpeNUTxwttHREdqKFpyc=;
        b=LrbCWyCE0Gmdqj0Qh+r8b7I8gCmbR1dcVglZTbkyYaKZ8iH1OY23+R1ls3qZEALJR1
         6m2vf8yTUu2/MwLVf74OhYJdJozzURDnW3jBtH3DwZw4ijGgIVDcPkg4n5KLNAu1kVvb
         W2kLATfHltArjqdUWgTNkbdiGb+BHWFMy7jDJ/6/aX8iFeY+0ez39HpRTnRBShWopW8a
         VNG6Ya2CyQaKXXxY9cIgMARBIz9nvN7I3lvMZnBwal+ytNy9oqf1dFNVsNClSR6PsN7U
         sErFKs3PvtnWMJWttPdVbGcVZL/E7ouhKjUbECYse/OVcE02VLac2ihRfSYUUOcYyYiR
         GKbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:content-transfer-encoding;
        bh=CSAMl7EJyJdjDOiZuTQVDV1QpeNUTxwttHREdqKFpyc=;
        b=Z3Cc1YC0R/DuOYl/PF/nQBKT9EntluBq5Mt3xS4sfDo0T7fPmU8SpEByjWWbZjo5FT
         dl54NG1QSu0t8WWTDolRBGYRcjqeTyzzm2Y+N/KYh+rBQuMBvnROsKW3ZDzI7p36SNRH
         zgQNKjMAGYky9WvuTlE6oWKPBck9qAsRC/CEsi9OKnfZ/r+6brcYK9v3GvV+rClJgcq8
         yTUuixVLjaskfRaO4gZAAKLl2BY7QiyvjkBmNh1tQUdTPVenBquhubmIDjBsYrnNP4jr
         Gw4DOh0RO4gIwz+fvKgu0ls7C4Qe0YbbGT+rCCrDx0N4av/DKFU95rQgAN4ia2Zoxywc
         E7ww==
X-Gm-Message-State: APjAAAXt3iLxieqyHhlma9b25F/e1oN6UlJnaE8pEHoSZgIgh+/UolKD
        73kDX0DvZWSXM22/i71NfkkfPp04lS8=
X-Google-Smtp-Source: APXvYqwlxttXlwPbdfYUVkStfQe5gJvHYsAJdjYHSKIuR7oonq+gT9OLezsdvJLbNudRSmjtk7/nqQ==
X-Received: by 2002:a1c:1b41:: with SMTP id b62mr5530422wmb.53.1578584844152;
        Thu, 09 Jan 2020 07:47:24 -0800 (PST)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id i5sm8570367wrv.34.2020.01.09.07.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jan 2020 07:47:22 -0800 (PST)
Date:   Thu, 9 Jan 2020 16:47:21 +0100
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ganapathi Bhat <gbhat@marvell.com>, ganapathi.bhat@nxp.com,
        linux-wireless@vger.kernel.org
Subject: MAINTAINERS: Marvell adresses might need update
Message-ID: <20200109154721.GA282857@eldamar.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

While replying to patch review request for 3.16.81-rc1 in
https://lore.kernel.org/lkml/20200109121117.GB1270@lorien.valinor.li/
including Ganapathi Bhat, I got a notification that NXP has acquired
Marvell’s Wireless business unit and Ganapathi can be reached under
ganapathi.bhat@nxp.com .

This probably means that at least the entry for Ganapathi Bhat in the
MAINTAINERS file needs an update and the .mailcap file.

This is as well the address as used in
https://lore.kernel.org/lkml/DB7PR04MB5242BEB1F917B1FDB21DF3DF8F3F0@DB7PR04MB5242.eurprd04.prod.outlook.com/
.

Regards,
Salvatore
