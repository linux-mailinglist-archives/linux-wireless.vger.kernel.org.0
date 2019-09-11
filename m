Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 716CBAFE09
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2019 15:49:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728031AbfIKNtt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Sep 2019 09:49:49 -0400
Received: from mail2.candelatech.com ([208.74.158.173]:59258 "EHLO
        mail3.candelatech.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727093AbfIKNtt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Sep 2019 09:49:49 -0400
Received: from [192.168.1.47] (unknown [50.34.216.97])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 8342D104F
        for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2019 06:49:48 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8342D104F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1568209788;
        bh=NaipIfkGrhS2BzDcsbqXwJMYQME3kR4iYUsU3S/o90U=;
        h=To:From:Subject:Date:From;
        b=jULQAqpDuRzd/G09jqj3cXBzCzsSgHltcx0s8ZKta7+JSprOvg/33feyjFbQ/8GW+
         j3gEyCgy0nWkoVDw94UbQquYyuQ9Rv8/OaMhX+1iwPDF4JUtkCnd+7/BEEyvI2sEMq
         bZ1Y3MMNZnyT+br3NvAnFbQ+FDIISOCxX+IGDtK8=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Question on Intel AX200
Message-ID: <33bd9a39-0028-2f99-f43e-5e15c9e87287@candelatech.com>
Date:   Wed, 11 Sep 2019 06:49:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

Does anyone know how well AX200 currently supports:

OFDMA

MU-MIMO (receiver)

AP Mode

And, can anyone suggest a good /AX AP to test against for these features?

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
