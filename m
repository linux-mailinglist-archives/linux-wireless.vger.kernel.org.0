Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B34F24D8A14
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Mar 2022 17:44:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243258AbiCNQoZ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 14 Mar 2022 12:44:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244478AbiCNQnw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 14 Mar 2022 12:43:52 -0400
X-Greylist: delayed 374 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 14 Mar 2022 09:42:35 PDT
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [45.33.216.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A41024704D
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 09:42:35 -0700 (PDT)
Received: from smtpclient.apple (macbook3.redfish-solutions.com [192.168.3.4])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.16.1/8.16.1) with ESMTPSA id 22EGaKAY550429
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-wireless@vger.kernel.org>; Mon, 14 Mar 2022 10:36:20 -0600
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
Content-Type: text/plain;
        charset=us-ascii
Content-Transfer-Encoding: 8BIT
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: WiFi 6 certified location service
Message-Id: <764F6734-F6E0-45F1-A4A7-6372F108573C@redfish-solutions.com>
Date:   Mon, 14 Mar 2022 10:36:19 -0600
To:     linux-wireless@vger.kernel.org
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Scanned-By: MIMEDefang 2.85 on 192.168.4.3
X-Spam-Status: No, score=-0.0 required=5.0 tests=BAYES_40,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I was wondering what's involved in getting Linux to support WiFi-6 certified location service?

Does that require timestamping in the drivers?  Or is the service provided in user-space like hostapd?

Is anyone working on it?

Thanks,

-Philip

