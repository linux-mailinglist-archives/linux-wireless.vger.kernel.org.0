Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46FCD4DA676
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 00:51:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349335AbiCOXwc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 19:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240824AbiCOXwb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 19:52:31 -0400
Received: from mail.redfish-solutions.com (mail.redfish-solutions.com [45.33.216.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 095531C10F
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 16:51:18 -0700 (PDT)
Received: from smtpclient.apple (macbook3.redfish-solutions.com [192.168.3.4])
        (authenticated bits=0)
        by mail.redfish-solutions.com (8.16.1/8.16.1) with ESMTPSA id 22FNpFM1558792
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Mar 2022 17:51:15 -0600
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 15.0 \(3693.60.0.1.1\))
Subject: Re: WiFi 6 certified location service
From:   Philip Prindeville <philipp_subx@redfish-solutions.com>
In-Reply-To: <afd90d3a-4c39-b609-18f2-9505600e7ef1@lockie.ca>
Date:   Tue, 15 Mar 2022 17:51:15 -0600
Cc:     linux-wireless@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <EEEB9832-9E95-4E4C-9529-29462D7F9EC5@redfish-solutions.com>
References: <764F6734-F6E0-45F1-A4A7-6372F108573C@redfish-solutions.com>
 <afd90d3a-4c39-b609-18f2-9505600e7ef1@lockie.ca>
To:     James <bjlockie@lockie.ca>
X-Mailer: Apple Mail (2.3693.60.0.1.1)
X-Scanned-By: MIMEDefang 2.85 on 192.168.4.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Have a look at:

https://www.wi-fi.org/discover-wi-fi/wi-fi-location


> On Mar 15, 2022, at 5:49 PM, James <bjlockie@lockie.ca> wrote:
> 
> 
> What is that?
> Searching wasn't clear.
> 
> On 2022-03-14 12:36, Philip Prindeville wrote:
>> Hi,
>> 
>> I was wondering what's involved in getting Linux to support WiFi-6 certified location service?
>> 
>> Does that require timestamping in the drivers?  Or is the service provided in user-space like hostapd?
>> 
>> Is anyone working on it?
>> 
>> Thanks,
>> 
>> -Philip
>> 
> 

