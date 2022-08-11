Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24F458FACA
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Aug 2022 12:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234078AbiHKKiP (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Aug 2022 06:38:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234494AbiHKKiI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Aug 2022 06:38:08 -0400
Received: from mx1.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E67C9018E
        for <linux-wireless@vger.kernel.org>; Thu, 11 Aug 2022 03:38:06 -0700 (PDT)
Received: from [192.168.0.2] (ip5f5aea52.dynamic.kabel-deutschland.de [95.90.234.82])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 1F8CA61EA192C;
        Thu, 11 Aug 2022 12:38:03 +0200 (CEST)
Message-ID: <17d91c3a-3431-9465-d01a-1611df84ecd3@molgen.mpg.de>
Date:   Thu, 11 Aug 2022 12:38:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.1.1
Content-Language: en-US
From:   Paul Menzel <pmenzel@molgen.mpg.de>
To:     Gregory Greenman <gregory.greenman@intel.com>
Cc:     linux-wireless@vger.kernel.org
Subject: iwlwifi: Direct firmware load for iwlwifi-so-a0-gf-a0-72.ucode failed
 with error -2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dear Linux folks,


On the Alder Lake laptop Dell XPS 13 9315, Linux 5.19 seems to want to 
load the firmware `iwlwifi-so-a0-gf-a0-72.ucode` not yet in the 
linux-firmware archive [1]:

     [   36.295707] iwlwifi 0000:00:14.3: Direct firmware load for 
iwlwifi-so-a0-gf-a0-72.ucode failed with error -2
     [   36.303128] iwlwifi 0000:00:14.3: api flags index 2 larger than 
supported by driver
     [   36.303157] iwlwifi 0000:00:14.3: TLV_FW_FSEQ_VERSION: FSEQ 
Version: 0.0.2.36
     [   36.303808] iwlwifi 0000:00:14.3: loaded firmware version 
71.058653f6.0 so-a0-gf-a0-71.ucode op_mode iwlmvm

There is a file with -73 [2] in the name, but that does not seem to be 
tried. Is -72 going to be uploaded?


Kind regards,

Paul


[1]: 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/
[2]: 
https://git.kernel.org/pub/scm/linux/kernel/git/firmware/linux-firmware.git/commit/iwlwifi-so-a0-gf-a0-73.ucode?id=99cb4b095b7679596ed9fbf1578568df18377866
