Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92206642C3D
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Dec 2022 16:49:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230519AbiLEPtJ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Dec 2022 10:49:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiLEPtI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Dec 2022 10:49:08 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7DB211459
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 07:49:07 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.28])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E06B41A006F
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 15:49:04 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id B5981380091
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 15:49:04 +0000 (UTC)
Received: from [10.0.0.50] (cpe-98-151-114-119.hawaii.res.rr.com [98.151.114.119])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 163E713C2B0
        for <linux-wireless@vger.kernel.org>; Mon,  5 Dec 2022 07:49:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 163E713C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1670255344;
        bh=zwqi49IGcXCGDmmQqFN3yq55lhbwQlInGuZPVQrWqmo=;
        h=Date:To:From:Subject:From;
        b=ZprMNRjwGpF36HZq9zWoHNCYzoLY8kR28ImG+Cvbze2PHmImijF1dJ1LkwNuUaHVT
         bMesdz5SYBOfnKyjRCifgGEhIKA+tTVsvjIK2uh+RaOuW9mFqvRiyliOQAePDlfupb
         sKuMTqqHwjpYqQyokq6kKjmiXqHn7Y8yRDIp6OSY=
Message-ID: <a8a2c506-96c8-1850-0585-cda09d4b31f0@candelatech.com>
Date:   Mon, 5 Dec 2022 07:49:03 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Language: en-MW
From:   Ben Greear <greearb@candelatech.com>
Subject: ax210: Ability to report noise floor?
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1670255345-Ni6DoeC3XWSf
X-MDID-O: us5-at1-1670255345-Ni6DoeC3XWSf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Is there any way to get Intel ax210 to report the noise floor?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
