Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 510E0474E3E
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Dec 2021 23:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhLNW4Q (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Dec 2021 17:56:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234975AbhLNW4Q (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Dec 2021 17:56:16 -0500
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [IPv6:2001:67c:2050::465:102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35068C061574;
        Tue, 14 Dec 2021 14:56:16 -0800 (PST)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4JDDJC0nG4zQkm1;
        Tue, 14 Dec 2021 23:56:11 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hauke-m.de; s=MBO0001;
        t=1639522568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=lL7qIPr/BcvXYZ76roGh6iV6Fx5G8UyVXxBw6oquLv0=;
        b=eohUnl0U7UGMvAv8hx+7LbO0NunGSjmLiO1JIRDoDPtOZ546mcNUC2d68AsdlZ1HSarg2D
        aoHhx1aNFj3earoR2UOEPmp6ioX4RGfQYkDzhfLdmYX1Lw9Xr8SEOzSV+/fVk+rZTn/T5t
        uIiIDLa5atRG9ytWXxE2xvH8jG60Obdz62PflyLoXbyui7mUrCRzrUGn56k1yEiRiBOeRX
        reXOFugHZoa1LV+PLUi+lled70wmovBZkLWWFbO27Lj3mVBb2+EKliyQ8ZBDGbdi/zXS4F
        EIRjWq2ikXuNGZQC0eFjC+vvfNxMxHO3y1v5X8emeHm/DpplLs4wFOvqfZl2hA==
To:     "backports@vger.kernel.org" <backports@vger.kernel.org>
Cc:     linux-wireless@vger.kernel.org
From:   Hauke Mehrtens <hauke@hauke-m.de>
Subject: wireless backports 5.15.8-1 released
Message-ID: <ed3ae36b-b927-466c-31f4-ec7f3aa1ec06@hauke-m.de>
Date:   Tue, 14 Dec 2021 23:56:06 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi

backports-5.15.8-1 was released. This is based on Linux 5.15.8.
https://cdn.kernel.org/pub/linux/kernel/projects/backports/stable/v5.15.8/backports-5.15.8-1.tar.xz

All versions after backports 5.10 will only work with kernel 4.4 and 
later, support for older kernel versions was removed.

There is now a updated wiki page with the releases:
https://backports.wiki.kernel.org/index.php/Releases

The source code can be found here:
https://git.kernel.org/cgit/linux/kernel/git/backports/backports.git/

Hauke
