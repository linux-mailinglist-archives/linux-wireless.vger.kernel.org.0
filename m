Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1631433A2A
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2019 23:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbfFCVuc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 Jun 2019 17:50:32 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:34468 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726049AbfFCVub (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 Jun 2019 17:50:31 -0400
Received: from mail-it1-f200.google.com ([209.85.166.200])
        by youngberry.canonical.com with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <seth.forshee@canonical.com>)
        id 1hXuqb-0007Ex-Pq
        for linux-wireless@vger.kernel.org; Mon, 03 Jun 2019 21:50:29 +0000
Received: by mail-it1-f200.google.com with SMTP id l124so16251470itg.6
        for <linux-wireless@vger.kernel.org>; Mon, 03 Jun 2019 14:50:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=LlXO6hhps9rbl1E0zyCpqhAOCYnTOmYP038tg6U8D+o=;
        b=LdCH7FlZZPjBJ2mE/dbpFaRB2AWlQGZ4/X+drFcM2cx6Xsm6fY/zZGt/2YnSkLF5m9
         JYoOa138uiQp0QVMGEc5q71e9d3Vp7ylyAJnRxjcrZgSeH6Y0WQBCbWgg7NFniqUVUox
         Sd7cXLNGaCGfHW5PQh9kvAkjO6b4vnocmcVPGBNF1yV3eo8mbnQVOrGo/+DzhH7psymP
         h1l3m836EatP9zjAugrSCJ3+mCH40CBcaUACNGSA3EWB7k1uJeXjH5b/ZenFpIr+iT4b
         kOGPBx3PEQVDG3g2dZx4YPTckGnR5RLESiMjUds8tYr9qNCNG9FUWMFhXCCAkT7uvZIU
         0Bhw==
X-Gm-Message-State: APjAAAVb6ukgnS5gMNZfLks2fWGl9i6Xvtp102CjsMoJelKZblQi+W74
        cnqu+xGbKCANlSk+UzrEJ4bDyunY/HqA+j07LRqqKGjWzvMU3kBvie7AP3XyuEcBuhBNV89y5Hv
        KawXRQ4uLg4vTKvgwXGM0Z2gwYgex3l09qpSPcxbrWGtB
X-Received: by 2002:a5d:8e0e:: with SMTP id e14mr12308820iod.118.1559598628753;
        Mon, 03 Jun 2019 14:50:28 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwmQiO5aC5p4mzpUM5UB5mhx9LJiCTiBjYZ6LMAC8v1l7DimfEti00oGzVCB5WbRjC4dMAhiw==
X-Received: by 2002:a5d:8e0e:: with SMTP id e14mr12308809iod.118.1559598628474;
        Mon, 03 Jun 2019 14:50:28 -0700 (PDT)
Received: from localhost ([2605:a601:ac2:fb20:9969:6580:f7d1:e724])
        by smtp.gmail.com with ESMTPSA id c2sm5383854iok.53.2019.06.03.14.50.27
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 03 Jun 2019 14:50:27 -0700 (PDT)
Date:   Mon, 3 Jun 2019 16:50:27 -0500
From:   Seth Forshee <seth.forshee@canonical.com>
To:     wireless-regdb@lists.infradead.org
Cc:     linux-wireless@vger.kernel.org
Subject: [ANN] wireless-regdb: master-2019-06-03
Message-ID: <20190603215027.GH4357@ubuntu-xps13>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

A new release of wireless-regdb (master-2019-06-03) is available at:

https://www.kernel.org/pub/software/network/wireless-regdb/wireless-regdb-2019.06.03.tar.gz

The short log of changes since the 2019-03-01 release is below.

Thanks,
Seth

---

Peter Oh (1):
      wireless-regdb: Update regulatory rules for South Korea

Seth Forshee (2):
      wireless-regdb: Expand 60 GHz band for Japan to 57-66 GHz
      wireless-regdb: update regulatory database based on preceding changes

Vladimir Koutny (1):
      wireless-regdb: Update regulatory rules for Japan (JP) on 5GHz

Xose Vazquez Perez (2):
      wireless-regdb: update source of information for ES
      wireless-regdb: update source of information for CU

