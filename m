Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53BC96C106D
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Mar 2023 12:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230113AbjCTLM7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Mar 2023 07:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCTLMg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Mar 2023 07:12:36 -0400
X-Greylist: delayed 897 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 20 Mar 2023 04:09:32 PDT
Received: from smtp-190b.mail.infomaniak.ch (smtp-190b.mail.infomaniak.ch [IPv6:2001:1600:3:17::190b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 096377687
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 04:09:32 -0700 (PDT)
Received: from smtp-2-0000.mail.infomaniak.ch (unknown [10.5.36.107])
        by smtp-2-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PgBCR3RSXzMqwmD
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 11:42:59 +0100 (CET)
Received: from unknown by smtp-2-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PgBCR0mDgzN4g2L
        for <linux-wireless@vger.kernel.org>; Mon, 20 Mar 2023 11:42:59 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fls.name; s=20200831;
        t=1679308979; bh=Lma60nXP550+UCP16rUELrA4V1sjOi8lkzUxK/7yYG0=;
        h=Date:Subject:From:Reply-To:To:References:In-Reply-To:From;
        b=eDJib/alrrnifYe/cvmZ6dNCT34n5T4pJpKWKZraqLSlRptuO+fc6O4bhV7VZzcFY
         JYyqsJowEPCjCDW/E65sEwPif6kLsDIShR0JmR1rp9APRyR6JDBJJYOtpI4Zx7zFgF
         PibNCP411WYFcn7CgqV+XfzMq31wL7apndOZguB0=
Message-ID: <2f3ea768bc27a26918a4e8a4363b8c97@mail.infomaniak.com>
Date:   Mon, 20 Mar 2023 11:42:59 +0100
Subject: wifi: mt76: mt7915e: mt7916 monitor ampdu id is invalid
From:   Florian Schmidt <florian@fls.name>
Reply-To: Florian Schmidt <florian@fls.name>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-WS-User-Origin: eyJpdiI6IksvZXEyYlpXWGRHSWNHcWZzVUd3T3c9PSIsInZhbHVlIjoiekFlVnk3S3c1VDVhaFIzanljR0tXUT09IiwibWFjIjoiYjc5NWI2YzQzYjczYzUyNjdiNWNlMWRjMWJlZTYyY2RhYjU0ODQ1NzlhOGFlYWM1MWIwZDQxNjdmMjZkYTExOCIsInRhZyI6IiJ9
X-WS-User-Mbox: eyJpdiI6Ik5xUFNqbTdhVnRLcU5XRWtzYlhWaHc9PSIsInZhbHVlIjoiU0VRQVl5Nnh5Z1FqQnZTUHpCa3F5UT09IiwibWFjIjoiY2E2Y2U1YzgwOTI5ZWQ0Mzg0MDY2ZTBlOWRlMWI0OTEwYTc1ZWUyYTcxODk5MWNlMTA4ODI3NWFhMTg3ODM5YiIsInRhZyI6IiJ9
X-WS-Location: eJxzKUpMKykGAAfpAmU-
X-Mailer: Infomaniak Workspace (1.3.465)
References: <c7fc198f2a4ed9c1345a05c0397a9fc5@mail.infomaniak.com>
In-Reply-To: <c7fc198f2a4ed9c1345a05c0397a9fc5@mail.infomaniak.com>
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi all,

Using a mt7916 in monitor mode, I see that the AMPDU reference number is in=
cremented for each part of a single AMPDU. Instead it should be constant, a=
nd ideally, the last subframe field should be set on the last part of the A=
MPDU. Capturing the same traffic with an intel AX200 show each parts of the=
 AMPDU with the same id as expected.

This issue is still present using kernel from tag wireless-testing-2023-03-=
16.

How can I be of any assist investigating and fixing this issue?

Thanks,
Florian
