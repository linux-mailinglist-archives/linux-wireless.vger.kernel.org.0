Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D209D9AA98
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2019 10:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390104AbfHWIrl (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Aug 2019 04:47:41 -0400
Received: from mga17.intel.com ([192.55.52.151]:54559 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732418AbfHWIrk (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Aug 2019 04:47:40 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 23 Aug 2019 01:47:40 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,420,1559545200"; 
   d="scan'208";a="379699010"
Received: from monicaar-mobl1.amr.corp.intel.com ([10.252.26.241])
  by fmsmga006.fm.intel.com with ESMTP; 23 Aug 2019 01:47:39 -0700
Message-ID: <1cfaffb7bcd3bf1e8ff9f18fda0cfbee4b716176.camel@intel.com>
Subject: Re: [bug report] iwlwifi: Add support for SAR South Korea limitation
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>, haim.dreyfuss@intel.com
Cc:     linux-wireless@vger.kernel.org
Date:   Fri, 23 Aug 2019 11:47:38 +0300
In-Reply-To: <20190806142435.GA13072@mwanda>
References: <20190806142435.GA13072@mwanda>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Dan,

On Tue, 2019-08-06 at 17:24 +0300, Dan Carpenter wrote:
> Hello Haim Dreyfuss,
> 
> The patch 0c3d7282233c: "iwlwifi: Add support for SAR South Korea
> limitation" from Feb 27, 2019, leads to the following static checker
> warning:
> 
> 	drivers/net/wireless/intel/iwlwifi/fw/acpi.c:166 iwl_acpi_get_mcc()
> 	warn: passing a valid pointer to 'PTR_ERR'
> 
> drivers/net/wireless/intel/iwlwifi/fw/acpi.c
>    153  int iwl_acpi_get_mcc(struct device *dev, char *mcc)
>    154  {
>    155          union acpi_object *wifi_pkg, *data;
>    156          u32 mcc_val;
>    157          int ret, tbl_rev;
>    158  
>    159          data = iwl_acpi_get_object(dev, ACPI_WRDD_METHOD);
>    160          if (IS_ERR(data))
>    161                  return PTR_ERR(data);
>    162  
>    163          wifi_pkg = iwl_acpi_get_wifi_pkg(dev, data, ACPI_WRDD_WIFI_DATA_SIZE,
>    164                                           &tbl_rev);
>    165          if (IS_ERR(wifi_pkg) || tbl_rev != 0) {
>                                         ^^^^^^^^^^^^
> wifi_pkg is not a valid error code.  Also it feels like it might be more
> future proof to blacklist rev 1 instead of whitelisting rev 0.

Yeah, this code is wrong.  If wifi_pkg is valid but tbl_rev is != 0,
then we will return a valid pointer instead of an error.  I'll fix
this.

But regarding blacklisting one, I think it's better as it is.  We mean
that the only revision we support is 0, if we get 1 or higher, we
return -EINVAL, because we handle it.  When we add support for other
revisions, we need to change it.


>    166                  ret = PTR_ERR(wifi_pkg);
>    167                  goto out_free;
>    168          }


Thanks for reporting!

(and yeah, I'll handle the other occurrences you mentioned too).

--
Cheers,
Luca.


