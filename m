Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C50C44DA672
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Mar 2022 00:50:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352648AbiCOXu7 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 15 Mar 2022 19:50:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352645AbiCOXu7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 15 Mar 2022 19:50:59 -0400
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577C61C10F
        for <linux-wireless@vger.kernel.org>; Tue, 15 Mar 2022 16:49:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=D3PNH76kBeoMuk8yfiXL1QzoPfPeI/KjqTIqsMjX3yM=; b=ur/uKQ0j/mh0UCt7o21aLrTya7
        sfDRFs6ydEUCV3z3FF3GJ5K5iPOMKoig7d8+f/5wWyIt22aEiqQ/35XuDcQuu0ROnIpSvtPzB0Ii3
        QccimeJIqHupxew3tX+H8vxFtyuEv045raPrPDsKKq6nabi/UNprVTNC46eSZb6/9dVYXICmsUvC+
        Z3CzO3jdb1FgLaO5kl4epxweza4iDuvLTg0J/+AiRE5uwlYq7QZP6nriybdb53sfJTpS6v4c+Rolv
        fo/6oCZKus4/oONJ7N4japgXZ3FBkEmPKheD5h9oNXp1Dl/eMLcjSxn3a2HObYBQn5zRQLCgvIFWn
        Vp9KVTHQ==;
Received: from [216.168.124.37] (port=34102 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nUGvB-0001JJ-Ud; Wed, 16 Mar 2022 10:49:44 +1100
Message-ID: <afd90d3a-4c39-b609-18f2-9505600e7ef1@lockie.ca>
Date:   Tue, 15 Mar 2022 19:49:44 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: WiFi 6 certified location service
Content-Language: en-US
To:     Philip Prindeville <philipp_subx@redfish-solutions.com>,
        linux-wireless@vger.kernel.org
References: <764F6734-F6E0-45F1-A4A7-6372F108573C@redfish-solutions.com>
From:   James <bjlockie@lockie.ca>
In-Reply-To: <764F6734-F6E0-45F1-A4A7-6372F108573C@redfish-solutions.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - titan.planetwebservers.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - lockie.ca
X-Get-Message-Sender-Via: titan.planetwebservers.net: authenticated_id: bjlockie@lockie.ca
X-Authenticated-Sender: titan.planetwebservers.net: bjlockie@lockie.ca
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-From-Rewrite: unmodified, already matched
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


What is that?
Searching wasn't clear.

On 2022-03-14 12:36, Philip Prindeville wrote:
> Hi,
>
> I was wondering what's involved in getting Linux to support WiFi-6 certified location service?
>
> Does that require timestamping in the drivers?  Or is the service provided in user-space like hostapd?
>
> Is anyone working on it?
>
> Thanks,
>
> -Philip
>

