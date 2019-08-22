Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58AAB98BAA
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Aug 2019 08:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731846AbfHVGuw (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Aug 2019 02:50:52 -0400
Received: from mga18.intel.com ([134.134.136.126]:10924 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbfHVGut (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Aug 2019 02:50:49 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 21 Aug 2019 23:50:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,415,1559545200"; 
   d="scan'208";a="330271496"
Received: from pkacprow-mobl.ger.corp.intel.com ([10.252.30.96])
  by orsmga004.jf.intel.com with ESMTP; 21 Aug 2019 23:50:47 -0700
Message-ID: <a5b555a03f97a73064bd5d7927dd16379642baa0.camel@intel.com>
Subject: Re: Regression with the latest iwlwifi 9260 and Canon Point firmware
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Peter Robinson <pbrobinson@gmail.com>
Cc:     linux-wireless@vger.kernel.org
Date:   Thu, 22 Aug 2019 09:50:46 +0300
In-Reply-To: <CALeDE9Mwtm8fVMm6Ce99aju=UqPPSaZWQR+zZtJodENZ6_m+_Q@mail.gmail.com>
References: <CALeDE9Mwtm8fVMm6Ce99aju=UqPPSaZWQR+zZtJodENZ6_m+_Q@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.30.5-1.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 2019-07-29 at 19:49 +0100, Peter Robinson wrote:
> Hi Luca,
> 
> Similar to the issues seen in the thread on [1] thje 9260 we're seeing
> the same reports in Fedora on both versions of the firmware [2], on
> both the 9260 series but also the Cannon Point-LP CNVi wifi devices as
> well. There's more details and dmesg output in that bug report.
> 
> Do you have an update on the issue?

Hi,

Please check this bugzilla entry:

https://patchwork.kernel.org/patch/11021735/

The bug has been fixed with this patch:

https://patchwork.kernel.org/patch/11021735/

HTH.

--
Cheers,
Luca.

