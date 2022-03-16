Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B69FC4DB867
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 20:12:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236571AbiCPTNg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 16 Mar 2022 15:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbiCPTNf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 16 Mar 2022 15:13:35 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D81523F8BC
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 12:12:20 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.120])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 97BAF1C0088
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 19:12:19 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 7593834006A
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 19:12:19 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1203113C2B0
        for <linux-wireless@vger.kernel.org>; Wed, 16 Mar 2022 12:12:19 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1203113C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1647457939;
        bh=sQ0GYyc/Ihh0/K3/gZRb+S1e3KZrG6BCOPt8bSpzOgM=;
        h=Subject:From:To:References:Date:In-Reply-To:From;
        b=jlVI1XKjcqRQYJGlso/V+XGXgD5MUBFtZwb5p988XUWEzHAvLHvox5krgW2MwAY5G
         eV6F25Ni7wz0WT8pZL08Hhj+83NZi6pbFyywrzxBf6jK+U0TQ9LCPWOMB1ZR8J20SD
         5mFB+YBZRreyM682rmxJKv+rWJoTpqIM0bg5Hmuk=
Subject: Re: ax210 txpower settings issue.
From:   Ben Greear <greearb@candelatech.com>
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <0cdac27e-5beb-51d4-4f27-9cd84cd1f7dd@candelatech.com>
Organization: Candela Technologies
Message-ID: <c2a09a33-5248-92bb-a076-8cf0b6be018b@candelatech.com>
Date:   Wed, 16 Mar 2022 12:12:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <0cdac27e-5beb-51d4-4f27-9cd84cd1f7dd@candelatech.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-MDID: 1647457940-lNcHnVmq6RaA
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 3/16/22 12:05 PM, Ben Greear wrote:
> I notice that when I try to set txpower on ax210 to 20 in a particular setup, then
> the peer RSSI reports -51.  If I change txpower to 15, peer reports about -53.  If I change
> txpower to 10, peer reports about -57.

Bleh, I should have just gone to lunch before sending email.  Setting to 0
takes it to -68 rssi, so total span is ~17db, and that is probably just fine.

Thanks,
Ben

> 
> I am wondering if ax210 somewhere might be using 1/2 db units when it should be using full db units
> or vice versa?
> 
> I'm using firmware version 71 and 5.17+ kernel (with the 5.18 iwlwifi patches backported).
> 
> Anyone tried similar?
> 
> Thanks,
> Ben
> 

