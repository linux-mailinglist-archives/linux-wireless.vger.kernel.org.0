Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14A5F7BDF7
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2019 12:04:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbfGaKET (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 31 Jul 2019 06:04:19 -0400
Received: from smtp.codeaurora.org ([198.145.29.96]:40870 "EHLO
        smtp.codeaurora.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725866AbfGaKET (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 31 Jul 2019 06:04:19 -0400
Received: by smtp.codeaurora.org (Postfix, from userid 1000)
        id 181C060734; Wed, 31 Jul 2019 10:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564567459;
        bh=CdbO+zNLJrPslRH6pFLmag0YsGRHU6AwLmxkM+GsuOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RNgIcBiFheRONxE4N8rxxSU+UgNf4iKhNRvn4s/svoAZachwBBt0eLyTHVFSZwyq0
         XxQ7Zf6aggepu/ke5UfHdcXXAXpxkR2n/yC/0/tFn1v0Dm3EU6pZP1MFKPwFtTAevF
         2m5imGMhu8TNsHH4k3iYFVlbnl4NUba56j03QbKQ=
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        pdx-caf-mail.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        DKIM_INVALID,DKIM_SIGNED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        by smtp.codeaurora.org (Postfix) with ESMTP id 5ED43602F1;
        Wed, 31 Jul 2019 10:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=codeaurora.org;
        s=default; t=1564567458;
        bh=CdbO+zNLJrPslRH6pFLmag0YsGRHU6AwLmxkM+GsuOo=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=O+DKFFOQcih27I6TyA/PRa1/O375bqjAEsaDWhkbLYGf9Ql+n2PuvjtoOLFMoHkh+
         DOABWAbI+0U/qzRoebPbX2Fc6Fkj/toaldSVAARi20qoKLy/CYN2Dy3FDYTS2+oOkp
         N5LDTneo1OXUoV6p58bvrrlnojF+T9bXJpBbnON0=
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 31 Jul 2019 15:34:18 +0530
From:   Tamizh chelvam <tamizhr@codeaurora.org>
To:     Sergey Matyukevich <sergey.matyukevich.os@quantenna.com>
Cc:     johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org
Subject: Re: [PATCHv6 1/9] nl80211: New netlink command for TID specific
 configuration
In-Reply-To: <20190711125111.vd4rfixmotyusuai@bars>
References: <1560835632-17405-1-git-send-email-tamizhr@codeaurora.org>
 <1560835632-17405-2-git-send-email-tamizhr@codeaurora.org>
 <20190711125111.vd4rfixmotyusuai@bars>
Message-ID: <edc16458451377681b540553e1ddea75@codeaurora.org>
X-Sender: tamizhr@codeaurora.org
User-Agent: Roundcube Webmail/1.2.5
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 2019-07-11 18:21, Sergey Matyukevich wrote:
>> Add a new NL command, NL80211_CMD_SET_TID_CONFIG to support
>> data TID specific configuration. This per TID configurations
>> are passed in NL80211_ATTR_TID_CONFIG which is a nested
>> attribute. This patch adds support to configure per TID
>> noack policy through NL80211_TID_ATTR_CONFIG_NOACK attribute.
>> Data TID value for this configuration will be passed through
>> NL80211_TID_ATTR_CONFIG_TID attribute. When the user-space wants
>> this configuration peer specific rather than being applied for
>> all the connected stations, MAC address of the peer can be passed
>> in NL80211_ATTR_MAC attribute. This patch introduced
>> enum ieee80211_tid_conf_mask to notify the driver that which
>> configuration modified.
>> Driver supporting data TID specific noack policy configuration
>> should be advertise through NL80211_EXT_FEATURE_PER_TID_NOACK_CONFIG
>> and supporting per STA data TID noack policy configuration
>> should be advertise through NL80211_EXT_FEATURE_PER_STA_NOACK_CONFIG
>> 
>> Signed-off-by: Tamizh chelvam <tamizhr@codeaurora.org>
> 
> ...
> 
>> +static int parse_tid_conf(struct cfg80211_registered_device *rdev,
>> +                         struct nlattr *attrs[],
>> +                         struct ieee80211_tid_cfg *tid_conf,
>> +                         struct genl_info *info, const u8 *peer)
>> +{
> 
> ...
> 
> 
>> +static int nl80211_set_tid_config(struct sk_buff *skb,
>> +                                 struct genl_info *info)
>> +{
>> +       struct cfg80211_registered_device *rdev = info->user_ptr[0];
>> +       struct nlattr *attrs[NL80211_TID_ATTR_CONFIG_MAX + 1];
>> +       struct net_device *dev = info->user_ptr[1];
>> +       struct ieee80211_tid_config *tid_config;
>> +       struct nlattr *tid;
>> +       int conf_idx = 0, rem_conf;
>> +       int ret = -EINVAL;
>> +       u32 num_conf = 0;
>> +
>> +       if (!info->attrs[NL80211_ATTR_TID_CONFIG])
>> +               return -EINVAL;
>> +
>> +       if (!rdev->ops->set_tid_config)
>> +               return -EOPNOTSUPP;
>> +
>> +       nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
>> +                           rem_conf)
>> +               num_conf++;
>> +
>> +       tid_config = kzalloc(struct_size(tid_config, tid_conf, 
>> num_conf),
>> +                            GFP_KERNEL);
>> +       if (!tid_config)
>> +               return -ENOMEM;
>> +
>> +       tid_config->n_tid_conf = num_conf;
>> +
>> +       if (info->attrs[NL80211_ATTR_MAC])
>> +               tid_config->peer = 
>> nla_data(info->attrs[NL80211_ATTR_MAC]);
>> +
>> +       nla_for_each_nested(tid, info->attrs[NL80211_ATTR_TID_CONFIG],
>> +                           rem_conf) {
>> +               ret = nla_parse_nested_deprecated(attrs, 
>> NL80211_TID_ATTR_CONFIG_MAX,
>> +                                                 tid, NULL, NULL);
>> +
>> +               if (ret)
>> +                       goto bad_tid_conf;
>> +
>> +               if (!attrs[NL80211_TID_ATTR_CONFIG_TID]) {
>> +                       ret = -EINVAL;
>> +                       goto bad_tid_conf;
>> +               }
>> +
>> +               ret = parse_tid_conf(rdev, attrs,
>> +                                    &tid_config->tid_conf[conf_idx],
>> +                                    tid_config->peer);
> 
> 
> Argument 'info' is missing here from parse_tid_conf. IIUC, appropriate
> fixup is included into patch #5. So it looks like rebase issue. But it
> makes sense to fix it since this issue makes the patch set 
> non-bisectable.
> 
My bad. Yes, it is missed in the rebase. I will fix that.

Thanks,
Tamizh.
