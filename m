Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 084E434F1B3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Mar 2021 21:38:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233170AbhC3Thl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Mar 2021 15:37:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233239AbhC3ThO (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Mar 2021 15:37:14 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00D65C061574;
        Tue, 30 Mar 2021 12:37:11 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id o126so25567484lfa.0;
        Tue, 30 Mar 2021 12:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PN0ITuLODcXOPSsvYDbIM9ZgkLNmjUqrMgzEkKmqNA8=;
        b=I0hqyVhDr2W/Cq0rmUE+jk/bVDpm13OVD80OiiII00BO6s4TyYtSHltc4eYtGQJo5I
         XUeCCpJJ1AKPDXh9lUJhdONebDnP7AnYG+FlNS0TkHEyV332/Bqe56ASpLinWnkpt9D2
         bZW7BVrGWDE5W2tV2x+Xa+ha884BImdN/+jyy7LH5m8KfYW77WKpXsFc89bEIVvFrKUM
         f7QymocxB4GN7+OgsvCdnPO9DJ4lyRM6qaPfX3EmJQ+YZadmVLfJzOH6k2OeW5kJ2dTL
         f20/w5lRmWSMWQQbHkJ0fjyWZCI5HEAWZlzE40o267MOqZ1MkNdfhPtu/6bqQFJG7XHI
         lV4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PN0ITuLODcXOPSsvYDbIM9ZgkLNmjUqrMgzEkKmqNA8=;
        b=sC6wnafoCiZVaaQ48mJ1E4YS+v5/ab4xVfEg4EHavQkIxzbnmtI/HTUPf2f/LAYJp5
         jZuBQmxwsJ/MsIBEMhuBic3Pnrw7FK3oG1tsblR/QPk+oZCdmw5jJ7H8UdnX5uMd8Ms0
         Pg7+1H+YHO2ugvfCtIZTu/RQ53h6VWAhhyrqAj1Ux2kWt4ZsR470pgDKOXjGFpqMkZsO
         0vfPRLsWd1MVParc2uSYGYxk3dWNXKlMYokaWx1u7+Q/kpv8RzaqY6/RQkimNSHbZRly
         vdQZLIY5LGQ6a5BTr5apzZUNYXQgWAIv2y2bFMpF4D7XLBs5/zKzK6I2leXRPnJ8dd3i
         CSnw==
X-Gm-Message-State: AOAM531LiEcnjYIuhK3oOaJKxXHvV+9OE16gqdbn1nGe7vCpLN/zVGBl
        yrrrIMr+fiC9u1PEGK0V8o0=
X-Google-Smtp-Source: ABdhPJzlfKQMRYBdDzeA9TViH3CRCWgl19d2bVnUryIG9g1eerIdUBPcordYYE2ws6wCPCi8xxb6iw==
X-Received: by 2002:ac2:58fc:: with SMTP id v28mr19680340lfo.201.1617133029525;
        Tue, 30 Mar 2021 12:37:09 -0700 (PDT)
Received: from localhost.localdomain ([94.103.229.149])
        by smtp.gmail.com with ESMTPSA id p22sm2270457lfh.113.2021.03.30.12.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Mar 2021 12:37:09 -0700 (PDT)
From:   Pavel Skripkin <paskripkin@gmail.com>
To:     brookebasile@gmail.com
Cc:     ath9k-devel@qca.qualcomm.com, davem@davemloft.net,
        gregkh@linuxfoundation.org, kuba@kernel.org, kvalo@codeaurora.org,
        linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        syzbot+89bd486af9427a9fc605@syzkaller.appspotmail.com,
        syzkaller-bugs@googlegroups.com
Subject: Memory leak in ath9k_hif_usb_dealloc_tx_urbs()
Date:   Tue, 30 Mar 2021 22:36:52 +0300
Message-Id: <20210330193652.10642-1-paskripkin@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20200911071427.32354-1-brookebasile@gmail.com>
References: <20200911071427.32354-1-brookebasile@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

I did some debugging on this
https://syzkaller.appspot.com/bug?id=3ea507fb3c47426497b52bd82b8ef0dd5b6cc7ee
and, I believe, I recognized the problem. The problem appears in case of
ath9k_htc_hw_init() fail. In case of this fail all tx_buf->urb krefs will be
initialized to 1, but in free function:

static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)

....

static void ath9k_hif_usb_dealloc_tx_urbs(struct hif_device_usb *hif_dev)
{
    ...
	list_for_each_entry_safe(tx_buf, tx_buf_tmp,
				 &hif_dev->tx.tx_buf, list) {
		usb_get_urb(tx_buf->urb);
		...
		usb_free_urb(tx_buf->urb);
		...
		}

Krefs are incremented and then decremented, that means urbs won't be freed.
I found your patch and I can't properly understand why You added usb_get_urb(tx_buf->urb).
Can You explain please, I believe this will help me or somebody to fix this ussue :)

With regards,
Pavel Skripkin
