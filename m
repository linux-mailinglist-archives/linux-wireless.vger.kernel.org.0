Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF0944FE907
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Apr 2022 21:42:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242789AbiDLTor convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 12 Apr 2022 15:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344922AbiDLToe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 12 Apr 2022 15:44:34 -0400
Received: from localhost.localdomain (mail.redfish-solutions.com [45.33.216.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5FD53B50
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 12:40:28 -0700 (PDT)
Received: from smtpclient.apple (macbook3.redfish-solutions.com [192.168.3.4])
        (authenticated bits=0)
        by localhost.localdomain (8.16.1/8.16.1) with ESMTPSA id 23CJeRe8722342
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Tue, 12 Apr 2022 13:40:27 -0600
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain;
        charset=utf-8
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: What's required for WiFi 6 Certified Location service?
Message-Id: <D6C016DA-086E-4CB1-80DA-A40839B714AE@redfish-solutions.com>
Date:   Tue, 12 Apr 2022 13:40:27 -0600
To:     linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3696.80.82.1.1)
X-Scanned-By: MIMEDefang 2.85 on 192.168.4.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

Not my wheelhouse...  and I've not read through the WiFi 6 Certified Location service specification, but does anyone have an idea of what would be required to support this in out-of-the-box Linux?

Per this news release:

https://www.wi-fi.org/news-events/newsroom/wi-fi-certified-location-brings-wi-fi-indoor-positioning-capabilities

> Wi-Fi Location™, based on the Fine Timing Measurement (FTM) protocol from IEEE 802.11-2016, delivers meter-level accuracy for indoor device location data.

Looking in include/linux/ieee80211.h I see:

include/linux/ieee80211.h:	WLAN_PUB_ACTION_FTM_REQUEST = 32,
include/linux/ieee80211.h:	WLAN_PUB_ACTION_FTM = 33,

But these don't appear anywhere else in the tree.

It also states:

> Each AP in a Wi-Fi Location network is configured with its exact location, including geospatial coordinates (latitude, longitude, and altitude), and civic address. This allows more precise location determination than with other solutions, even in multilevel structures.

But doesn't specify how that location is exchanged with the client.

Is anyone in the Linux kernel community working on an FTM implementation?

Thanks

