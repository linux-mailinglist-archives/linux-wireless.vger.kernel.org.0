Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3D8CB595F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2019 03:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728664AbfIRBll (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Sep 2019 21:41:41 -0400
Received: from mga04.intel.com ([192.55.52.120]:12077 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728596AbfIRBll (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Sep 2019 21:41:41 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Sep 2019 18:41:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,518,1559545200"; 
   d="scan'208";a="189108316"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.6]) ([10.239.13.6])
  by orsmga003.jf.intel.com with ESMTP; 17 Sep 2019 18:41:39 -0700
Subject: Re: [kbuild-all] [PATCH] staging: wilc1000: look for rtc_clk clock in
 spi mode
To:     Adham.Abozaeid@microchip.com, lkp@intel.com
Cc:     devel@driverdev.osuosl.org, Ajay.Kathat@microchip.com,
        gregkh@linuxfoundation.org, linux-wireless@vger.kernel.org,
        kbuild-all@01.org, Eugen.Hristev@microchip.com,
        johannes@sipsolutions.net
References: <20190916193701.20755-1-adham.abozaeid@microchip.com>
 <201909170853.9YktTPSZ%lkp@intel.com>
 <4b015529-aeaa-b01f-01ce-1a81cbe2aea9@microchip.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <2a45205b-b9f1-b985-4a75-546b454c2e54@intel.com>
Date:   Wed, 18 Sep 2019 09:41:29 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <4b015529-aeaa-b01f-01ce-1a81cbe2aea9@microchip.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Adham,

On 9/17/19 9:03 AM, Adham.Abozaeid@microchip.com wrote:
>
> On 9/16/19 5:49 PM, kbuild test robot wrote:
>> [auto build test ERROR on linus/master]
>> [cannot apply to v5.3 next-20190916]
>> [if your patch is applied to the wrong git tree, please drop us a note to help improve the system]
> This patch applies for staging-testing, not linus/master.
>
>

Thanks for clarification, we'll take a look. BTW 0day-CI introduced 
'--base' option to record base tree info in format-patch.
could you kindly add it to help robot to base on the right tree? please 
see https://stackoverflow.com/a/37406982

Best Regards,
Rong Chen
