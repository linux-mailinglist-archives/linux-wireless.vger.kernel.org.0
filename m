Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E3AB6B70D9
	for <lists+linux-wireless@lfdr.de>; Mon, 13 Mar 2023 09:07:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230389AbjCMIH2 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 13 Mar 2023 04:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCMIG5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 13 Mar 2023 04:06:57 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BD504EEF
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 01:04:36 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j3so7225754wms.2
        for <linux-wireless@vger.kernel.org>; Mon, 13 Mar 2023 01:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1678694675;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HvC0W03zYk4hR2w7J8T+RUoaA0jU84QBNCQ+UXgjkc4=;
        b=ZpYHhdhR7QJbjSUL7L6N/XkxKNF1HM5Aa4NLp487qVPRAKZ3T92s/O1QnzGc00zhsP
         NHEV5WAd/zMRrOfbMjLFQmCfkALOWwUCvYOCx3idYevbWu+ep8Dbkv6UuSbGCSfC9o9W
         bz0C+0BbTx9hWgIBeUZa63501EukzFYzQOOI+MLIJahJpwRvJFIYd3zErrs/vAh2TLiv
         4VmOmtjznRsfthqgaqoa3/Lwg9tOBDSrE6LWWeg/KNpKHuNCx8TiEhZiIsOoW5kHfL3b
         KcbSEdZ8jg9eyJVxygkdYO5ZU0k9ZQnzMEWZPicMBASKVJBzj1lxiWQN64dLtA2RFN+Q
         9wSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678694675;
        h=in-reply-to:from:content-language:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HvC0W03zYk4hR2w7J8T+RUoaA0jU84QBNCQ+UXgjkc4=;
        b=aL/REH8j0K8p3OaspmCKyvcAowYsRVgN37+fIIZoLquWALMGMKasDx2y2xEJulVH6R
         D0anDSu6Pi5eBRPxz+3jg/RXbk28j7bNhMqSsS1jCMr/jjC25qegXb0BR2ofbPo/ntcq
         plLFR87d5QztEBWDoLLqngnj8pvNbtctgv2fmAgLibw4OCvZIq1TlOPxphnejKI9t3YB
         8MUUg0IMLqLkhy0oImPM35YdbNowqw6hisMw4tsgeTDEUI3MWdKbOKQQ3UGAnhJ5ffzD
         wZZOcsjzUvxEi+7pycN6fzF59JLdj7GuPQYSLtj2Mog7Y4Z2fd+gqxXBxsOg5BzOgUcs
         Ix5A==
X-Gm-Message-State: AO0yUKWwZeHAR7xRFTsBlsENGnN+KiUwIjevRhqy0HV4QLBecnU8TJlX
        A6Yh5CKAsxinLEAp+YH6OxOVDA==
X-Google-Smtp-Source: AK7set/caMzMtwpEGnKz4lJ5BYolxDau4FEwNK2QaS95qEFuyWLJyDaVoU87QIbLddnMaum890JfQg==
X-Received: by 2002:a05:600c:3c9e:b0:3e1:f8af:8772 with SMTP id bg30-20020a05600c3c9e00b003e1f8af8772mr9616059wmb.9.1678694674778;
        Mon, 13 Mar 2023 01:04:34 -0700 (PDT)
Received: from ?IPV6:2a02:578:8593:1200:610b:b98a:1680:79a? ([2a02:578:8593:1200:610b:b98a:1680:79a])
        by smtp.gmail.com with ESMTPSA id 10-20020a05600c22ca00b003eb3933ef10sm8098228wmg.46.2023.03.13.01.04.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 01:04:34 -0700 (PDT)
Content-Type: multipart/mixed; boundary="------------BN05b59QBxweVj2jyGSFeb48"
Message-ID: <be8f3f53-e1aa-1983-e8fb-9eb55c929da5@tessares.net>
Date:   Mon, 13 Mar 2023 09:04:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: pull-request: wireless-2023-03-10: manual merge
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Jakub Kicinski <kuba@kernel.org>
References: <20230310114647.35422-1-johannes@sipsolutions.net>
Content-Language: en-GB
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
In-Reply-To: <20230310114647.35422-1-johannes@sipsolutions.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a multi-part message in MIME format.
--------------BN05b59QBxweVj2jyGSFeb48
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Johannes,

(+cc Jakub and Stephen)

On 10/03/2023 12:46, Johannes Berg wrote:
> Hi,
> 
> For now in wireless we only have a few fixes for some
> recently reported (and mostly recently introduced)
> problems.

(...)

> Johannes Berg (4):
>       wifi: nl80211: fix NULL-ptr deref in offchan check
>       wifi: nl80211: fix puncturing bitmap policy

FYI, we got a small conflict when merging -net in net-next in the MPTCP
tree due to this patch applied in -net:

  b27f07c50a73 ("wifi: nl80211: fix puncturing bitmap policy")

and this one from net-next:

  cbbaf2bb829b ("wifi: nl80211: add a command to enable/disable HW
timestamping")

The conflict has been resolved on our side[1] by keeping the
modifications from both sides and the resolution we suggest is attached
to this email.

Cheers,
Matt

[1] https://github.com/multipath-tcp/mptcp_net-next/commit/a95a213e49af
-- 
Tessares | Belgium | Hybrid Access Solutions
www.tessares.net
--------------BN05b59QBxweVj2jyGSFeb48
Content-Type: text/x-patch; charset=UTF-8;
 name="a95a213e49afeb23fc8f6ce561366886e31b5692.patch"
Content-Disposition: attachment;
 filename="a95a213e49afeb23fc8f6ce561366886e31b5692.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWNjIG5ldC93aXJlbGVzcy9ubDgwMjExLmMKaW5kZXggMGEzMWIxZDI4NDVkLDRm
NjMwNTllZmQ4MS4uYmZhMTVkZWZjMDRlCi0tLSBhL25ldC93aXJlbGVzcy9ubDgwMjExLmMK
KysrIGIvbmV0L3dpcmVsZXNzL25sODAyMTEuYwpAQEAgLTgwNSwxMCAtODEwLDggKzgxMCwx
MSBAQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBubGFfcG9saWN5IG5sODAyMTFfCiAgCVtOTDgw
MjExX0FUVFJfTUxEX0FERFJdID0gTkxBX1BPTElDWV9FWEFDVF9MRU4oRVRIX0FMRU4pLAog
IAlbTkw4MDIxMV9BVFRSX01MT19TVVBQT1JUXSA9IHsgLnR5cGUgPSBOTEFfRkxBRyB9LAog
IAlbTkw4MDIxMV9BVFRSX01BWF9OVU1fQUtNX1NVSVRFU10gPSB7IC50eXBlID0gTkxBX1JF
SkVDVCB9LAotIAlbTkw4MDIxMV9BVFRSX1BVTkNUX0JJVE1BUF0gPSBOTEFfUE9MSUNZX1JB
TkdFKE5MQV9VOCwgMCwgMHhmZmZmKSwKKyAJW05MODAyMTFfQVRUUl9QVU5DVF9CSVRNQVBd
ID0KKyAJCU5MQV9QT0xJQ1lfRlVMTF9SQU5HRShOTEFfVTMyLCAmbmw4MDIxMV9wdW5jdF9i
aXRtYXBfcmFuZ2UpLAogKwogKwlbTkw4MDIxMV9BVFRSX01BWF9IV19USU1FU1RBTVBfUEVF
UlNdID0geyAudHlwZSA9IE5MQV9VMTYgfSwKICsJW05MODAyMTFfQVRUUl9IV19USU1FU1RB
TVBfRU5BQkxFRF0gPSB7IC50eXBlID0gTkxBX0ZMQUcgfSwKICB9OwogIAogIC8qIHBvbGlj
eSBmb3IgdGhlIGtleSBhdHRyaWJ1dGVzICovCg==

--------------BN05b59QBxweVj2jyGSFeb48--
