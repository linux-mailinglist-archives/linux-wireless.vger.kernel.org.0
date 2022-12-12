Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6051649D89
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Dec 2022 12:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231160AbiLLL0c (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 12 Dec 2022 06:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231394AbiLLL0M (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 12 Dec 2022 06:26:12 -0500
X-Greylist: delayed 904 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Dec 2022 03:26:07 PST
Received: from sender4-of-o56.zoho.com (sender4-of-o56.zoho.com [136.143.188.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F837E2C
        for <linux-wireless@vger.kernel.org>; Mon, 12 Dec 2022 03:26:07 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670843460; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=P8ATCRNeS7CrZpiqS/5D6g/Rmg2kXyo3Me81MC8jqcrE4G6DRzaoLA+e/NuXH+NPlKYfWbuV85s0FIbJwA6JrOGeNv3mzK4CShcGUkeYfpj/xqPYEf01v9UF3jtCZCSwDgSg30+eZ0GKBnWHFt7LM1kyNK67WJeJKYZuKYJ6tYM=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670843460; h=Content-Type:Content-Transfer-Encoding:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=8YjlatOgfim3c4e1yzqSgNvBF1L6HS4j6nLCp2C8Rak=; 
        b=hvOj4TlNXLdtCJpzKfPj0EyI0zChKGxU7ajEGnidO/lrggbr7e2JlTF5Dl8XZADc35/7VSPAXmdxeivOJGt9jG4kZdzpSIa/eHwBJueKH8Mk6FzmZhwCgPJVnUOQDDC9+wjOw7+d4LBkifwBs7xxybrmbHzv//3JhLQeoghrAxY=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=charlespiekarski.com;
        spf=pass  smtp.mailfrom=contact@charlespiekarski.com;
        dmarc=pass header.from=<contact@charlespiekarski.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1670843460;
        s=zoho; d=charlespiekarski.com; i=contact@charlespiekarski.com;
        h=Message-ID:Date:Date:MIME-Version:To:To:From:From:Subject:Subject:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To:Cc;
        bh=8YjlatOgfim3c4e1yzqSgNvBF1L6HS4j6nLCp2C8Rak=;
        b=F9NUTwH+0auImIGocO+z+DeGI7x3UBJoHr93G/kSjkDT3hUONrUL2MgEL/X88Z39
        1bUfOZ/PCcIEp/XWwjPPPNYtyjdyFS6l/Q4hyEm2YZL0iUuffWeDCaVX/dqHLx4gdGa
        +AmIk3t67D85n7tQaugty+zeeJse7wQnnrHZjkCI=
Received: from [192.168.100.145] (195-166-223-48.fibre.u-mee.com [195.166.223.48]) by mx.zohomail.com
        with SMTPS id 1670843460132151.13554411423263; Mon, 12 Dec 2022 03:11:00 -0800 (PST)
Message-ID: <a2a454c5-3940-52d0-77b7-e5f8376720ae@charlespiekarski.com>
Date:   Mon, 12 Dec 2022 12:10:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     linux-wireless@vger.kernel.org
Content-Language: en-GB
From:   Charles Piekarski <contact@charlespiekarski.com>
Subject: Realtek 8852BE support
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DEAR_SOMETHING,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Sir or Madam,

I would like to kindly ask for information if Realtek 8852BE Wi-Fi 6 
module is supported or will be supported by the Linux kernel. 
Regrettably, the module does not work under Ubuntu 22.04.1 and 22.10, at 
least out of the box, and I was unable to find any useful information to 
get it working in a safe way (with Secure Boot enabled).

Kind regards,
Charles Piekarski

-- 

This email (including any attachments) is private, confidential and may 
contain privileged material. If you have received this email in error, 
please notify the sender and delete it (including any attachments) 
immediately. If you are not the addressee of this email, you must not 
copy, forward, distribute, disclose or use any of the information in it 
or any attachments.
