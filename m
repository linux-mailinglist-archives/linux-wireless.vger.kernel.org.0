Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED3463D70D
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Nov 2022 14:47:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiK3Nr3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 30 Nov 2022 08:47:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiK3Nr2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 30 Nov 2022 08:47:28 -0500
Received: from pv50p00im-zteg10011401.me.com (pv50p00im-zteg10011401.me.com [17.58.6.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D224EC04
        for <linux-wireless@vger.kernel.org>; Wed, 30 Nov 2022 05:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zzy040330.moe;
        s=sig1; t=1669816047;
        bh=kS26Uv3Vn2J916f/Yd9WWn/ESiic2vspI7WIPfk+zbg=;
        h=From:To:Subject:Date:Message-Id:MIME-Version;
        b=M4kVPTjmKxBeYI9VE4rNjtiYy+Yw3qXKaFSzCRVmgT7GxVPcQw5FIky6yDrW1b2Zv
         29FdR4IxKgmXbwfGXGqa3fJ5BG8miV+59JMQwqHve71vnVZTGOl4/HlLWPhw0ACH69
         BYwouA5rTfS71UbmTA+iqJNgWRHYS09R8YBP4kLdBT++A2iw2U7VBzoNWK5eCWYDXq
         hPtxKISwSzYkLfGKfcuX872E8v3KOX3MRgCcX30Bf5k8gh0/X5snljPpqaGI77xeDn
         kNjMZUY60INhbaewRgJTqB5R3NVcCVnAvqpVETC/3OT4gD5ggNtuf7M9Lni8shkyhp
         ZmoevJbzwWSow==
Received: from vanilla.. (pv50p00im-dlb-asmtp-mailmevip.me.com [17.56.9.10])
        by pv50p00im-zteg10011401.me.com (Postfix) with ESMTPSA id 629A6DC0AF0;
        Wed, 30 Nov 2022 13:47:25 +0000 (UTC)
From:   JunASAKA <JunASAKA@zzy040330.moe>
To:     rtl8821cerfe2@gmail.com
Cc:     Jes.Sorensen@gmail.com, linux-wireless@vger.kernel.org,
        pkshih@realtek.com
Subject: Re: [PATCH v3 3/3] wifi: rtl8xxxu: Introduce rtl8xxxu_update_ra_report
Date:   Wed, 30 Nov 2022 21:47:21 +0800
Message-Id: <20221130134721.116982-1-JunASAKA@zzy040330.moe>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <6321862a-3362-95b9-bbd1-be0d5fb97f7f@gmail.com>
References: <6321862a-3362-95b9-bbd1-be0d5fb97f7f@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: pB6Njmnu3Kuol8ml0fA2gst3rQQCcHOF
X-Proofpoint-GUID: pB6Njmnu3Kuol8ml0fA2gst3rQQCcHOF
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.517,18.0.883,17.11.64.514.0000000_definitions?=
 =?UTF-8?Q?=3D2022-06-21=5F08:2022-06-21=5F01,2022-06-21=5F08,2022-02-23?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=19 spamscore=19 mlxlogscore=64
 bulkscore=0 mlxscore=19 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1030 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2211300096
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
I am trying to merge this patch into the linux source tree (Mr. Torvalds' updated source tree) and find a confliection in patch 3/3.
I think you should move the rcu_read_unlock() that originally located in line 4657 to line 4682(right after the if-else section)
to make this patch work normally.

Jun ASAKA.
