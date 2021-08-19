Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90BE03F1CAD
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 17:26:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240315AbhHSP1U convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 11:27:20 -0400
Received: from coyote.holtmann.net ([212.227.132.17]:38214 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238643AbhHSP1U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 11:27:20 -0400
Received: from smtpclient.apple (p5b3d23f8.dip0.t-ipconnect.de [91.61.35.248])
        by mail.holtmann.org (Postfix) with ESMTPSA id 578CFCED18;
        Thu, 19 Aug 2021 17:26:42 +0200 (CEST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 14.0 \(3654.120.0.1.13\))
Subject: Re: [PATCH v3 2/2] btbcm: add patch ram for bluetooth
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <1cd0e008-9239-f430-7294-865d34795a2f@broadcom.com>
Date:   Thu, 19 Aug 2021 17:26:42 +0200
Cc:     Angus Ainslie <angus@akkea.ca>, kernel@puri.sm,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        linux-bluetooth@vger.kernel.org
Content-Transfer-Encoding: 8BIT
Message-Id: <5766C95B-D5A4-463C-A87F-41B35BF82046@holtmann.org>
References: <20210812165218.2508258-1-angus@akkea.ca>
 <20210812165218.2508258-3-angus@akkea.ca>
 <1cd0e008-9239-f430-7294-865d34795a2f@broadcom.com>
To:     Arend van Spriel <arend.vanspriel@broadcom.com>
X-Mailer: Apple Mail (2.3654.120.0.1.13)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Arend,

>> Bluetooth on the BCM43752 needs a patchram file to function correctly.
>> Signed-off-by: Angus Ainslie <angus@akkea.ca>
>> ---
>>  drivers/bluetooth/btbcm.c | 1 +
>>  1 file changed, 1 insertion(+)
>> diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
>> index e5d706ed55ea..e4182acee488 100644
>> --- a/drivers/bluetooth/btbcm.c
>> +++ b/drivers/bluetooth/btbcm.c
>> @@ -387,6 +387,7 @@ struct bcm_subver_table {
>>  };
>>    static const struct bcm_subver_table bcm_uart_subver_table[] = {
>> +	{ 0x1111, "BCM4362A2"	},	/* 000.017.017 */
> 
> Noticed Marcel applied this one already, but as I asked in earlier patch I would like to know why the commit message says 43752 but this entry says 4362? Still confused.

seems I missed that part. Can you look internally what this hardware is and we fix it?

Regards

Marcel

