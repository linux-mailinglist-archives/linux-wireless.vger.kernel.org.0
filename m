Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E898B188EC6
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Mar 2020 21:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgCQUPA (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Mar 2020 16:15:00 -0400
Received: from mga14.intel.com ([192.55.52.115]:25758 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726388AbgCQUPA (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Mar 2020 16:15:00 -0400
IronPort-SDR: zWwipJxgAWbumsWX2wvMO9u2B1T5KVkY7xjxg6kClkNE961vt8pUDDKdM1bhyFAV/cH5v0gv8P
 W2t1/NZYtd8A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 13:15:00 -0700
IronPort-SDR: SNOcLY15WTwcEsXIWvUOD63/kjkXnIKBv2pK7+hFugrkz9xMkQOZXeaQgzSHXJad0WhZMbctZ5
 abNYl9PfzuzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,565,1574150400"; 
   d="scan'208";a="355473795"
Received: from aericson-mobl.ger.corp.intel.com ([10.249.254.163])
  by fmsmga001.fm.intel.com with ESMTP; 17 Mar 2020 13:14:59 -0700
Message-ID: <3d90288f0b8c41bfcd5f44781e82eb9f62a3e48d.camel@intel.com>
Subject: Re: [PATCH] iwlwifi: set 'free_queue' to the loop variable, not a
 meaningless bool
From:   Luciano Coelho <luciano.coelho@intel.com>
To:     Mark Asselstine <asselsm@gmail.com>, johannes.berg@intel.com,
        linux-wireless <linux-wireless@vger.kernel.org>
Date:   Tue, 17 Mar 2020 22:14:58 +0200
In-Reply-To: <CAPuovEJWzAvCwWQq0E5MACxo=1Dk5pK4YyjH+d0W-bspAMJJQA@mail.gmail.com>
References: <20200313030545.9184-1-mark.asselstine@windriver.com>
         <CAPuovEJWzAvCwWQq0E5MACxo=1Dk5pK4YyjH+d0W-bspAMJJQA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.1-4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, 2020-03-17 at 16:12 -0400, Mark Asselstine wrote:
> Luca,
> 
> This is my first time sending a fix for iwlwifi and I haven't seen any
> feedback or seen the code merged. Should I have sent this somewhere
> else?

Hi Mark,

I'm sorry, I have a huge backlog of work and I'm trying to catch up.  I
will review your patch and apply it to our internal tree and then
upstream it according to our usual process asap.

Thanks for your patch!

--
Cheers,
Luca.

