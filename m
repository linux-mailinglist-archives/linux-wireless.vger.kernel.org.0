Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2C36736E4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Jan 2023 12:31:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbjASLb5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Jan 2023 06:31:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjASLbl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Jan 2023 06:31:41 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BB174EFF
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 03:31:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k16so1273054wms.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Jan 2023 03:31:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w4MawY+RzZ3a8j/CxqeRFLovjvxW/xeOy10spvpUMXM=;
        b=kMZSECKZT5G7uazvIJ/L6w7oRt185ee6Eo00hLJLGfjoCZE7T7+WK7GsbdxP0aVzq6
         Ye+4GeBuXdQrcLPd4Ey4/0HNhAiRnWFsZ2jLNKpV0/bW7t4oW8z4rdpVS422nkHYBa1N
         TWG7OlL4RnTQJg0Q76ziths3jX0DUkohwq0NSiO49jvDaRumkFl+uN2fZ/0HkUWp9zVu
         2aeS1b45RkF3FdPy9g/GyrrY8n88cgJ7MnU5kKuVpMTdoV1XgJDshX+k7DNRyx3KYAJ1
         y8Cu0fq92Nku0n2+xJpmJ3olIrGdq9IBH490IiKFx8aDTMnivc5WMjX4bLtHVQSgk+65
         lgJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w4MawY+RzZ3a8j/CxqeRFLovjvxW/xeOy10spvpUMXM=;
        b=iJfMO7Y3ED/cC5u2ct4cVWBoIk5qUDhcvkmev0WyzLKwmVCW762RsN/lcnL6ed8aEj
         Bk2ah7Up43pE5mmjqskChtJjtw9P9y8ShISg3EwDtnHS1HD0/JpZImdtUZLuwJHYOEwN
         49gRo+Wc3lJlBitBrJnAQjL+xzMIpr9Cdf8oRNPvrj+A3voCqqPbINsw3vgdpYxHZyiu
         bkXn7/ECoq9vbYFAim4Px1WAPufn9G7jvi+aWt2DR/AakGOa7ET8tOkIBvCmYCUenRKP
         4eTtGsPbBXer//TPhni1R042f7roLmwBiH3aRTIxoIO6PmINmsy6NmWAKklY1kW4FIoZ
         JGWw==
X-Gm-Message-State: AFqh2kop1wjso8xjCUmW0j+KVRSbqYwym+8xVxLhXWsJvVLyrZYwqjsd
        D8VSMsFCCcdsCT2HnVeERuM=
X-Google-Smtp-Source: AMrXdXsj9qc8ntDbw0mVkvSOAWchhjLmbjkm6f8uk1Eu0yOCTdGnoiWJ7EnuB97DP9u/b/EiblkKNQ==
X-Received: by 2002:a05:600c:3d16:b0:3cf:8b22:76b3 with SMTP id bh22-20020a05600c3d1600b003cf8b2276b3mr9635361wmb.0.1674127897946;
        Thu, 19 Jan 2023 03:31:37 -0800 (PST)
Received: from smtpclient.apple ([195.37.89.195])
        by smtp.gmail.com with ESMTPSA id bg14-20020a05600c3c8e00b003dab40f9eafsm5980460wmb.35.2023.01.19.03.31.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 19 Jan 2023 03:31:37 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [RFC v2 4/6] mac80211: add utility function for tx_rate -
 rate_info conversion
From:   Jonas Jelonek <jelonek.jonas@gmail.com>
In-Reply-To: <64731257b957f50b0f66e4d2fcd8c24dea8d70ff.camel@sipsolutions.net>
Date:   Thu, 19 Jan 2023 12:31:03 +0100
Cc:     linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9AE44A41-6357-4F3A-BF75-8E3B0A381E9B@gmail.com>
References: <20220920104032.496697-1-jelonek.jonas@gmail.com>
 <20220920104032.496697-5-jelonek.jonas@gmail.com>
 <64731257b957f50b0f66e4d2fcd8c24dea8d70ff.camel@sipsolutions.net>
To:     Johannes Berg <johannes@sipsolutions.net>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


> On 12. Jan 2023, at 11:26, Johannes Berg <johannes@sipsolutions.net> =
wrote:
>=20
>> +void ieee80211_rate_get_rate_info(const struct ieee80211_tx_rate =
*rate,
>> +						struct wiphy *wiphy, u8 =
band,
>> + 						struct rate_info =
*rate_info)
>> +{
>> + 	memset(rate_info, 0, sizeof(struct rate_info));
>> +
>> + 	if (rate->flags & IEEE80211_TX_RC_MCS) { /* 802.11n */
>> + 		rate_info->flags |=3D RATE_INFO_FLAGS_MCS;
>> + 		rate_info->mcs =3D rate->idx;
>> + 	} else if (rate->flags & IEEE80211_TX_RC_VHT_MCS) { /* 802.11ac =
*/
>> + 		rate_info->flags |=3D RATE_INFO_FLAGS_VHT_MCS;
>> + 		rate_info->mcs =3D ieee80211_rate_get_vht_mcs(rate);
>> + 		rate_info->nss =3D ieee80211_rate_get_vht_nss(rate);
>> + 	} else { /* 802.11a/b/g */
>=20
> what about HE/EHT?

ieee80211_tx_rate uses an s8 for rate/MCS index, so only up to VHT rates =
fit in there.
For rates above VHT, rate_info is needed, thus are are no HE/EHT rates =
occuring in
ieee80211_tx_rate. Same applies to your comment on the hwsim conversion.

Jonas=
