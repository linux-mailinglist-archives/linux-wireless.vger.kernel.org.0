Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0998B15CD6A
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2020 22:42:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727705AbgBMVmr (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 13 Feb 2020 16:42:47 -0500
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:40094 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726282AbgBMVmr (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 13 Feb 2020 16:42:47 -0500
Received: from [192.168.178.20] (unknown [93.209.2.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 724FE580073;
        Thu, 13 Feb 2020 22:42:45 +0100 (CET)
Subject: Re: [RFC PATCH] iw: add clang-based fuzzer for scan IEs
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org
References: <20200211114502.4250-1-markus.theil@tu-ilmenau.de>
 <03361a0c6f35db6aac6eab650d35e8ade0541d21.camel@sipsolutions.net>
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Message-ID: <508d7975-bbfe-3a95-e967-660491a79b0f@tu-ilmenau.de>
Date:   Thu, 13 Feb 2020 22:42:43 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <03361a0c6f35db6aac6eab650d35e8ade0541d21.camel@sipsolutions.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2/13/20 9:19 PM, Johannes Berg wrote:
> FWIW, I applied most of your patches, though some I squashed since you
> just introduced the bugs in a previous non-applied patch ... :)
;)
> Regarding the fuzzing ... how long did you run this?
The first bugs were found nearly instantly, the last ones after several 
minutes (<= 20).
> I adjusted this to afl-clang-fast (afl++, not the original) and it's not
> finding much easily...
>
> I guess making it realloc each element into a separate buffer so that
> it's checking out-of-bounds for each element separately will help
> somewhat, let's see...
>
> johannes
>
>
