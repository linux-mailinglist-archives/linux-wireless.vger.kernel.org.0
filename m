Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3667965D
	for <lists+linux-wireless@lfdr.de>; Tue, 24 Jan 2023 12:15:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233899AbjAXLO6 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 24 Jan 2023 06:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233930AbjAXLOw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 24 Jan 2023 06:14:52 -0500
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA7181284C
        for <linux-wireless@vger.kernel.org>; Tue, 24 Jan 2023 03:14:49 -0800 (PST)
Received: from [192.168.0.203] ([151.127.53.97]) by mrelayeu.kundenserver.de
 (mreue010 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1M9WeC-1pNYVv2ErM-005dS7; Tue, 24 Jan 2023 12:14:23 +0100
Message-ID: <eac1cf31-518f-6542-24c6-69e6c059f3c9@green-communications.fr>
Date:   Tue, 24 Jan 2023 12:13:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] nl80211: add support to enable/disable bss color
 collision detection
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     Johannes Berg <johannes@sipsolutions.net>,
        Rameshkumar Sundaram <quic_ramess@quicinc.com>,
        ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
References: <20221226083328.29051-1-quic_ramess@quicinc.com>
 <20221226083328.29051-2-quic_ramess@quicinc.com>
 <74c57dc34af10537f98f5bb9b6ce80e5676e09b0.camel@sipsolutions.net>
 <1609a645-3e23-7e37-9aa1-94f970e481e2@green-communications.fr>
 <Y8q5Z98S3pODD77W@lore-desk>
From:   Nicolas Cavallari <nicolas.cavallari@green-communications.fr>
In-Reply-To: <Y8q5Z98S3pODD77W@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:oE3dX4RdequYSrBHTUbDn30PfJAs+olUvBaNQZ0dN2uEXLP//tu
 tkp8/zSD/XZhXxetf421bXRlpg9cl92kzLzulLF7lCOLwAig62HxYMsGZmIAyPlSByuSWev
 ABxd8wqTWmvwMxSnrhi565vsSKiIUZVxGSkF2VyV7g6g5InrQ91oOFUqIvjBVYO4Fz158Z6
 h5YSEquMPhpgVv+znkIRw==
UI-OutboundReport: notjunk:1;M01:P0:Vl/qQ6SuslU=;L2McOHb4hLMTam33CIGM5BLgfSr
 Wnu/ttorfviXOSTwzlqhtPAzq1gmDTR22roMpUBRN8ti33AJ/GNCqT2OV8P1pyV/vGuk7k7/c
 4dqKFrNAyZEYmz0dBBgOPjeCQA4LAgrPfFikxm4DLJmPQHaRCMTVqteMX/fcLLsSpwRmTjH6S
 z7zgzyetUvszYhImD+5MvzXrfY2QlKeCySRUl85yR/GKkBQ5VdroZPpSBcAd+GyfpK6TxIXHE
 xIV0Xkm4NOzMnbo8vRMG5D/+64Q4T3rdqmOcm0ka0EwSe7X1i6VEaYrKWLVTha3c7BJ1F49o2
 V6tQPFzyBpi2KnXeHWANw9jRgIL6FoxQuvqQ4r/0zP5sqa8j4fjLIrjLXlVp3rY0sPGK+v1Na
 AhXCiT/b9vRgz3/1comQkOyQQJ/0PMOVwxfy+epeq/3P7zcuvOvJkoywbqS3esAOI0DtYtfA0
 BW3NVG3/bgNzmxFrhATF78vr/AnsLSFML2FpxTUYC+yW78rlOCPLe3tG5QQJZza7dISgCvoFw
 n2A8XMvN+bGpE+WcknD/6JSBdS63AO8FU8jG0FHIpGV3vqNf1oNtdc34BreOkYFZSgr8yIf6V
 K76pvHQ5+pjQqrrkVBBQPZVdKMBKNOBTk3h80aEJjtlXLhiZq0v9rZsX43FdTzMMo3QBIjiiw
 t6jE4Qwlvtv86Zq29NZlVVtUOukDNjZNgozRDkOnGw==
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

On 20/01/2023 16:55, Lorenzo Bianconi wrote:
> I agree, I think we can ratelimit netlink messages sent by the kernel to
> userspace (e.g. to hostapd), I would say every 500ms is ok.
> I guess we can move cfg80211_obss_color_collision_notify() in a dedicated
> delayed_work so we can grab wdev mutex (cfg80211_obss_color_collision_notify is
> currently running in interrupt context).
> To give an idea, what do you think about patch below? (please note it is just
> compiled tested so far).

The patch does not work, the fix appears easy:
> +void ieee80211_color_collision_detection_work(struct work_struct *work)
> +{
> +	struct delayed_work *delayed_work = to_delayed_work(work);
> +	struct ieee80211_link_data *link =
> +		container_of(delayed_work, struct ieee80211_link_data,
> +			     dfs_cac_timer_work);

This should probably be color_collision_detect_work.

> +	struct ieee80211_sub_if_data *sdata = link->sdata;
> +
> +	sdata_lock(sdata);

It crashed here, link is NULL.

> +	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
> +					     GFP_KERNEL);
> +	sdata_unlock(sdata);
> +}
Will test the fixed version later.
