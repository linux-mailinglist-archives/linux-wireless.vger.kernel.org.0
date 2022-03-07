Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9E234D04C4
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Mar 2022 17:58:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236233AbiCGQ7t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 7 Mar 2022 11:59:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232458AbiCGQ7t (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 7 Mar 2022 11:59:49 -0500
Received: from titan58.planetwebservers.net (titan58.planetwebservers.net [51.79.1.102])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34462A25D
        for <linux-wireless@vger.kernel.org>; Mon,  7 Mar 2022 08:58:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lockie.ca;
        s=default; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:References:Cc
        :To:From:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=0GbF9LczR84R4WjofQHfvc8VgYMMMhSD2MrVbSZe6jc=; b=KsOXvUYekDyfhdqj82UJB7OcN2
        EcnbgOK6S19/S/UJnXlqLCGkadTmfhy5jQldNYQwMERcE6ucNIH9lSYp0jFTP0V2b4N0f3lHC654l
        JoQjgZxF9PPq8NSzDcx3rc+5+PkK33O2i4vkHsGFWXVTuLQ9kxE6bCWa/fJH0QqXC13sxsgvrVoWz
        hcNKRP7nwLHQX+epSYBCICqRQYeEuB3rSmHRRpGWQCFjXpiCKxr4EdpOBQDR7dD4I9aHTqC2fRqk/
        TPRvk+MBPQj7cI/bLCobCwja7GlXctBW1t7WuELKzd3DuxX6+vtvv28/AIj2O1vquX6jUd2H2kgyJ
        b8xh/PfA==;
Received: from [216.168.124.37] (port=35780 helo=[192.168.68.65])
        by titan.planetwebservers.net with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <bjlockie@lockie.ca>)
        id 1nRGhB-0000HJ-EA; Tue, 08 Mar 2022 03:58:52 +1100
Message-ID: <3829238c-8726-93c9-9417-a594a15df529@lockie.ca>
Date:   Mon, 7 Mar 2022 11:58:51 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: MK7921K de-auths from AP every 5 minutes
Content-Language: en-US
From:   James <bjlockie@lockie.ca>
To:     Riccardo Paolo Bestetti <pbl@bestov.io>
Cc:     linux-wireless@vger.kernel.org
References: <CICSX6EXTZ6U.MYGFTUDU5ZKW@enhorning>
 <59a1cd3d-46a1-4442-9cec-380044fa0790@lockie.ca>
 <CIDPF6OMQ0MJ.10W2JI66K5FM1@enhorning>
 <1666def0-7cdd-4685-af62-f8df8b02ed21@lockie.ca>
In-Reply-To: <1666def0-7cdd-4685-af62-f8df8b02ed21@lockie.ca>
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

If you use wpa3, try wpa2.

