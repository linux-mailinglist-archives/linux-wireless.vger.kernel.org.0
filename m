Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F2C4913A0D4
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2020 07:00:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726297AbgANGAp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 14 Jan 2020 01:00:45 -0500
Received: from mail.adapt-ip.com ([173.164.178.19]:56814 "EHLO
        mail.adapt-ip.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgANGAp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 14 Jan 2020 01:00:45 -0500
Received: from localhost (unknown [127.0.0.1])
        by mail.adapt-ip.com (Postfix) with ESMTP id 30DCA2F0A3B;
        Tue, 14 Jan 2020 05:54:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at web.adapt-ip.com
Received: from mail.adapt-ip.com ([127.0.0.1])
        by localhost (web.adapt-ip.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 61Za-tfmX3Hl; Mon, 13 Jan 2020 21:54:43 -0800 (PST)
Received: from [10.10.10.201] (c-73-202-5-52.hsd1.ca.comcast.net [73.202.5.52])
        (using TLSv1.2 with cipher AES128-SHA (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: thomas@adapt-ip.com)
        by mail.adapt-ip.com (Postfix) with ESMTPSA id 8DAAA2F0A2E;
        Mon, 13 Jan 2020 21:54:43 -0800 (PST)
Subject: Re: [PATCH v2 0/3] fix a STA PS bug and add PS support to
 mac80211_hwsim
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <20191119053538.25979-1-thomas@adapt-ip.com>
 <85ed0881d0aeecd886b27bd482fa61fa86d96729.camel@sipsolutions.net>
 <f0ae4c07-d3c3-768f-49c0-1f2a6c5a687d@adapt-ip.com>
 <d943f37db7a57dbc335cacfa5cbbd38c8ae8dea9.camel@sipsolutions.net>
 <43f4d446d7f8b9a08e091ab811fbf99bf00da2af.camel@sipsolutions.net>
From:   Thomas Pedersen <thomas@adapt-ip.com>
Message-ID: <8ebb225f-8ec5-0897-03cd-f37bfdd94429@adapt-ip.com>
Date:   Mon, 13 Jan 2020 21:54:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <43f4d446d7f8b9a08e091ab811fbf99bf00da2af.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Johannes,

On 11/22/19 10:08 AM, Johannes Berg wrote:
> On Fri, 2019-11-22 at 19:04 +0100, Johannes Berg wrote:
>>
>> Various. Jouni just said mostly concurrency ones, e.g.
>>
>> p2p_cli_invite
>> ap_cipher_tkip_countermeasures_ap_mixed_mode
>> discovery_while_go_p2p_dev
>> radius_macacl_unreachable
> 
> Ah, still had my list open:
> 
> discovery_while_go radius_macacl_unreachable
> discovery_while_go_p2p_dev bgscan_learn_beacon_loss
> wifi_display_parsing ap_vlan_iface_cleanup_multibss
> ap_vlan_iface_cleanup_multibss_per_sta_vif
> autogo_2cli
> bgscan_simple_beacon_loss
> rrm_lci_req_timeout
> rrm_ftm_range_req_timeout
> p2p_cli_invite

Is there a list of known passing hwsim tests somewhere?

Maybe a subset of suites / tests you like to see passing as a smoke test?

Or do you run through the 3300+ tests and expect them all to pass?

Thanks,

-- 
-- thomas
