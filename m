Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A804FB986
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Apr 2022 12:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345396AbiDKK2h (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 11 Apr 2022 06:28:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345465AbiDKK10 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 11 Apr 2022 06:27:26 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D27C15A20;
        Mon, 11 Apr 2022 03:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1649672644;
        bh=+9daRbgguUMwpP1Kxzc4SvN3voTAJWybYQM3EaDwJJo=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Z0LzlkJzPt4uiS+QhlFVDfzpcK/Yx7IZFEeFDF29/J4G9xDFWEfV4DSRsLrhSxeKj
         szqiv9psLtYNSLX/XKvHKNiWJb2uJbUKkFuv0oax/ojmCkkewfaRyldaFLSwOqqY1y
         zMD/EA3MlgHJQMzUaVrccCEWbc0FmePeVrcqT+Xk=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from [192.168.86.95] ([95.91.192.147]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MwwZd-1nuJVQ3cHz-00yS91; Mon, 11
 Apr 2022 12:24:03 +0200
Message-ID: <1e1f0cc1-d4ae-c536-4ffc-256a0fd3a265@rempel-privat.de>
Date:   Mon, 11 Apr 2022 12:24:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] ath9k_htc: fix potential out of bounds access with
 invalid rxstatus->rs_keyix
Content-Language: en-US
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org
References: <20220409061225.GA5447@kili>
 <00a0f9f7-2fbf-8883-38e7-edec3687e6a8@rempel-privat.de>
 <20220411075403.GZ12805@kadam>
From:   Oleksij Rempel <linux@rempel-privat.de>
In-Reply-To: <20220411075403.GZ12805@kadam>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:9z/uUx7LeypGIMA8Xo4Ti3KohcDO8ft6RzVS/qEtYIQRnKw02zI
 mS26cYgT+emIt0vXWcpNosKSrC87EgVMiH0Q2SQh1NkgCeFrAkvuEmdL0Im65BJ0FXsi7f0
 RkkByPNz4NnXi6osF5AqWe6sMQK55XEcSQvI/37AUpSaDNzIHR7K+Kj4/4hnJyN4hEXmVV3
 a8/fB1RjhluMJIQbTsi7A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hJ0X/fBcs8s=:wNXWS3mdCYA+ct94nEa+Ke
 /5dss5PRkzVYart4H+HsdTbBFRFsZbOWVvv4OOlryM4ti3sogryYvVI6bE2nbFkchhV8BvmuJ
 a9Ll/O4yR2O8yzDFHejoMkaz5pR1aVTZjrNm+cQtWG1P3bp1TrZ30fDy5/4RHB4qPH4YAMzAV
 qy/O+/xn/4iZK/YMKzCcjjO/UYdqtXBwld3KHyZJ9m7MlMa+VIhke59q3UU+vg3271R4UVnUJ
 07I+nbX+B7vZUmyE48gkWssm+/TZTf9KoTUw51qUHJSM9kAQc7imHh7doX2wYT24TCHOMgXTE
 cucJ5bVQHzXMPH3taaWDNDkRgsfSgz24syaJiRyKxOz94ExA34FgX+SaSc0IeW9FcGBdtvNz5
 B3FPkTb/Uf17IydgqPKqIvW+TbLvjiHCiiZLyBUL3FUfg0wo7F+UfFPm4Vg6p3vaK/URi7srF
 7TcBabjTtQ8Nc7y/NTIA9jUiyHpLbud868p+JN8NdZBLN6aj4fgrijBQRIyJARjTYTQn77njs
 Y77+2F5bZhlYwYhw3O6Uvzb5ooal+gUejw9gc/1c0x1GIALDnziJZwUrhpm4K7db3pF4IBwfC
 XeesxuuySShhSd8ONBLnCxjSLnB958tMySdxPj8BJ/QxogX8AjQ1QTOHLGuNZGR7f/kvV3brb
 utIg6eqWoQKYrhfiGRwO3ZtfAaIdtCzRnQnbDLG+oO5b4UdEixJvLS8XNvnQz9P7Z7lT/kkrG
 ckKnRmS7Dg5L579HYPzfv3ibtcjgJHhCm0K7ae3xyh2+fABaipyGe6jGEUj8j8IOXj0J6YrK5
 wC3vhZ5Lj/KRAtT8RqHXIzG8/lzzl3yYGiig+Ha1Pm7qvfxEZ7Q0EjVBN2eHJW/rcsdIQXJT7
 HWMLnA5waIx09Q0jy7e+0gAY/ilZ6vopAAfAnIk9vAIRVc8aER9fhb5ySJhzNyF4p9rx7zjly
 GDH3kqTwOvy7wHXvSGQ3yrGJfMqlRu8axzT/NaDUwUZqdlfzP6VskTTNqNNyroD/u13SRFCiJ
 zbKv+1/+3Z3BmEtidYcSDMIxxZXSiHfmq+zoCjhTX/sO8KAoJEV6mTZPMBuOBSE9FwX1yfoSE
 8Op8aR/MlIQX64=
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Am 11.04.22 um 09:54 schrieb Dan Carpenter:
> On Sat, Apr 09, 2022 at 09:53:53AM +0200, Oleksij Rempel wrote:
>>> diff --git a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c b/drivers/n=
et/wireless/ath/ath9k/htc_drv_txrx.c
>>> index 6a850a0bfa8a..a23eaca0326d 100644
>>> --- a/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
>>> +++ b/drivers/net/wireless/ath/ath9k/htc_drv_txrx.c
>>> @@ -1016,6 +1016,14 @@ static bool ath9k_rx_prepare(struct ath9k_htc_p=
riv *priv,
>>>    		goto rx_next;
>>>    	}
>>>
>>> +	if (rxstatus->rs_keyix >=3D ATH_KEYMAX &&
>>> +	    rxstatus->rs_keyix !=3D ATH9K_RXKEYIX_INVALID) {
>>> +		ath_dbg(common, ANY,
>>> +			"Invalid keyix, dropping (keyix: %d)\n",
>>> +			rxstatus->rs_keyix);
>>> +		goto rx_next;
>>> +	}
>>> +
>>>    	/* Get the RX status information */
>>>
>>>    	memset(rx_status, 0, sizeof(struct ieee80211_rx_status));
>>
>> Looks ok to me.
>
> Thanks!
>
>>
>> By the way, rs_keyix seems to have a wrong type. It is declared as u8, =
but used as s8.
>
> That sounds like something outside the scope of the patch...

ack :)

> Why do you mean "used as s8"?  Which function are you talking about?
>
> You made me panic briefly because ATH9K_RXKEYIX_INVALID is a u8 so it
> needs to be u8.  I would have thought instinctively that u8 would be the
> right type for an index like this.

Because ATH_KEYMAX =3D=3D S8_MAX and ATH9K_RXKEYIX_INVALID is ((u8)-1)

All bitmap values within drivers/net/wireless/ath should never have BIT(7)=
 set, except it is -1.

=2D-
Regards,
Oleksij
