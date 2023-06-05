Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58927723198
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Jun 2023 22:42:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232516AbjFEUmT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 5 Jun 2023 16:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbjFEUmS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 5 Jun 2023 16:42:18 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2009AEA
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 13:42:17 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 517F6780075
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 20:42:15 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id DE8A413C2B1
        for <linux-wireless@vger.kernel.org>; Mon,  5 Jun 2023 13:42:14 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com DE8A413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1685997734;
        bh=7SGijsn2+6ZcogbD8FTMKtnDI4VOvEhq34d0Pmeep6Q=;
        h=Date:Subject:From:To:References:In-Reply-To:From;
        b=jxiVsmT7GpwXL8Aa3cwczohWZtAS1OLlogFdfPVJjsoRy4JnQS8BKG4JO/cOidxkz
         60ImUEf7LKA58WZO2iZ33sbxge4Z8KgRkOuafUXJAqTdN8KU0oXJHTfcalQN2LQYZM
         l4HF9rnB0VsA5N/O6IDiYBi6VG1WT7k5h3ZFngsg=
Message-ID: <4aaa46bf-26dd-fc4e-d4d9-7d0ee2028169@candelatech.com>
Date:   Mon, 5 Jun 2023 13:42:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: iwlwifi query on iwl_mvm_skb_prepare_status
Content-Language: en-US
From:   Ben Greear <greearb@candelatech.com>
To:     linux-wireless <linux-wireless@vger.kernel.org>
References: <f8416cc9-6601-8c98-2a15-8ac5882833ce@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <f8416cc9-6601-8c98-2a15-8ac5882833ce@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1685997735-6eWtzh5AIzGz
X-MDID-O: us5;ut7;1685997735;6eWtzh5AIzGz;<greearb@candelatech.com>;f7146c1849a4b08a52804beb1c1cdf45
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/5/23 13:04, Ben Greear wrote:
> I think the two memsets below access the same memory since skb_info
> contains a union?  So maybe only one is needed?
> 
> static void iwl_mvm_skb_prepare_status(struct sk_buff *skb,
>                         struct iwl_device_tx_cmd *cmd)
> {
>      struct ieee80211_tx_info *skb_info = IEEE80211_SKB_CB(skb);
> 
>      memset(&skb_info->status, 0, sizeof(skb_info->status));
>      memset(skb_info->driver_data, 0, sizeof(skb_info->driver_data));
> 
>      skb_info->driver_data[1] = cmd;
> }

Also, maybe that driver_data[1] assigment is not helpful?  From what I can tell,
mvm is putting the iwl_device_tx_cmd pointer at driver_data[3], by way of some cb offsets.

Are these notes below valid for mvm?

/* skb->cb usage for mvm
  *
  * driver_data[0]: unused
  * driver_data[1]: holds pointer to struct iwl_device_tx_cmd (un-used???)
  * driver_data[2]: cb + cb_data_offs, points to mac header page.
  * driver_data[3]: dev_cmd_offs: cb + cb_data_offs + sizeof(void*), holds pointer to struct iwl_device_tx_cmd.
  * driver_data[4]: unused.
  */

> 
> Thanks,
> Ben
> 

