Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC86D3B9DB8
	for <lists+linux-wireless@lfdr.de>; Fri,  2 Jul 2021 10:51:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230432AbhGBIxg (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 2 Jul 2021 04:53:36 -0400
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:63282 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230335AbhGBIxg (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 2 Jul 2021 04:53:36 -0400
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 1628lFdr029841;
        Fri, 2 Jul 2021 08:50:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : mime-version : content-type : in-reply-to;
 s=corp-2020-01-29; bh=7HkKCU5eSyiGh3FR3XxXr0VMlJwLuB1VURa9+UykhlY=;
 b=RiWYuiPMy5UFBhodxnomFkRqvIZtADK3Dnr4lIFNPj35Jj+2DVTEtyUFiO0BhQw+kfcR
 mXzGpwE5Q6b5mji+PzGVDBXWvxRTyFR3vyiK1InYN79z0CgxH+/oQhiCGY37JMoJ/RHb
 w0+J7P8m/UvomSIUvudrlStXJct16W7KiQhNc5bipPxmw79ZIW5Q2mEuPmILmpkzL7mg
 QTjL00g6qbRc/kq+sOul4C3Hh3Jemp7NhdQUDYqWWa7R85QKf+OXqg/x39ySwEgMf6zO
 0/x+ntlrdR+HZOzya7viWsUJNlhZGBrRUtP1f5YtYO+/LaGfnZAwjiGZ1xDjR2YaQnzh Yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 39gy5w393j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:50:52 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 1628a4sx185702;
        Fri, 2 Jul 2021 08:50:51 GMT
Received: from pps.reinject (localhost [127.0.0.1])
        by aserp3020.oracle.com with ESMTP id 39dv2ca9vm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:50:51 +0000
Received: from aserp3020.oracle.com (aserp3020.oracle.com [127.0.0.1])
        by pps.reinject (8.16.0.36/8.16.0.36) with SMTP id 1628oobQ028865;
        Fri, 2 Jul 2021 08:50:50 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by aserp3020.oracle.com with ESMTP id 39dv2ca9uc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 02 Jul 2021 08:50:50 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 1628oksD018448;
        Fri, 2 Jul 2021 08:50:46 GMT
Received: from kadam (/102.222.70.252)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 02 Jul 2021 08:50:45 +0000
Date:   Fri, 2 Jul 2021 11:50:37 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Lorenzo Bianconi <lorenzo@kernel.org>,
        johannes@sipsolutions.net
Cc:     lkp@intel.com, kbuild-all@lists.01.org, john@phrozen.org,
        nbd@nbd.name, lorenzo.bianconi@redhat.com,
        linux-wireless@vger.kernel.org, ryder.lee@mediatek.com
Subject: Re: [PATCH v8 mac80211-next 2/3] mac80211: add support for BSS color
 change
Message-ID: <202107021442.s4zM1rYi-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <637c350e2e5d3aeba7da6c28cd57c388234a7686.1624872141.git.lorenzo@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Proofpoint-GUID: wvD6yWbLdJQdi7YhIJHVvZRowNlbuWk6
X-Proofpoint-ORIG-GUID: wvD6yWbLdJQdi7YhIJHVvZRowNlbuWk6
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Lorenzo,

url:    https://github.com/0day-ci/linux/commits/Lorenzo-Bianconi/mac80211-add-BSS-color-change-support/20210628-172723
base:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git master
config: i386-randconfig-m021-20210630 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
net/mac80211/tx.c:4819 ieee80211_set_beacon_cntdwn() warn: variable dereferenced before check 'resp' (see line 4805)

Old smatch warnings:
net/mac80211/tx.c:1820 invoke_tx_handlers_late() warn: variable dereferenced before check 'tx->skb' (see line 1795)
net/mac80211/tx.c:3444 ieee80211_xmit_fast_finish() error: we previously assumed 'key' could be null (see line 3412)

vim +/resp +4819 net/mac80211/tx.c

8552a434b6a05c John Crispin          2020-08-11  4775  static void ieee80211_set_beacon_cntdwn(struct ieee80211_sub_if_data *sdata,
73da7d5bab79ad Simon Wunderlich      2013-07-11  4776  					struct beacon_data *beacon)
73da7d5bab79ad Simon Wunderlich      2013-07-11  4777  {
726d30f004a276 John Crispin          2021-06-28  4778  	u8 *beacon_data, count, max_count = 1;
726d30f004a276 John Crispin          2021-06-28  4779  	u16 *bcn_offsets, *resp_offsets;
73da7d5bab79ad Simon Wunderlich      2013-07-11  4780  	struct probe_resp *resp;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4781  	size_t beacon_data_len;
0d06d9ba93ad42 Andrei Otcheretianski 2014-05-09  4782  	int i;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4783  
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4784  	switch (sdata->vif.type) {
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4785  	case NL80211_IFTYPE_AP:
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4786  		beacon_data = beacon->tail;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4787  		beacon_data_len = beacon->tail_len;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4788  		break;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4789  	case NL80211_IFTYPE_ADHOC:
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4790  		beacon_data = beacon->head;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4791  		beacon_data_len = beacon->head_len;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4792  		break;
b8456a14e9d277 Chun-Yeow Yeoh        2013-10-17  4793  	case NL80211_IFTYPE_MESH_POINT:
b8456a14e9d277 Chun-Yeow Yeoh        2013-10-17  4794  		beacon_data = beacon->head;
b8456a14e9d277 Chun-Yeow Yeoh        2013-10-17  4795  		beacon_data_len = beacon->head_len;
b8456a14e9d277 Chun-Yeow Yeoh        2013-10-17  4796  		break;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4797  	default:
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4798  		return;
cd7760e62c2ac8 Simon Wunderlich      2013-08-28  4799  	}
0d06d9ba93ad42 Andrei Otcheretianski 2014-05-09  4800  
73da7d5bab79ad Simon Wunderlich      2013-07-11  4801  	rcu_read_lock();
73da7d5bab79ad Simon Wunderlich      2013-07-11  4802  	resp = rcu_dereference(sdata->u.ap.probe_resp);
73da7d5bab79ad Simon Wunderlich      2013-07-11  4803  
726d30f004a276 John Crispin          2021-06-28  4804  	bcn_offsets = beacon->cntdwn_counter_offsets;
726d30f004a276 John Crispin          2021-06-28 @4805  	resp_offsets = resp->cntdwn_counter_offsets;
                                                                       ^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This code assumes "resp" is non-NULL

726d30f004a276 John Crispin          2021-06-28  4806  	count = beacon->cntdwn_current_counter;
726d30f004a276 John Crispin          2021-06-28  4807  	if (sdata->vif.csa_active)
726d30f004a276 John Crispin          2021-06-28  4808  		max_count = IEEE80211_MAX_CNTDWN_COUNTERS_NUM;
726d30f004a276 John Crispin          2021-06-28  4809  
726d30f004a276 John Crispin          2021-06-28  4810  	for (i = 0; i < max_count; ++i) {
726d30f004a276 John Crispin          2021-06-28  4811  		if (bcn_offsets[i]) {
726d30f004a276 John Crispin          2021-06-28  4812  			if (WARN_ON_ONCE(bcn_offsets[i] >= beacon_data_len)) {
73da7d5bab79ad Simon Wunderlich      2013-07-11  4813  				rcu_read_unlock();
73da7d5bab79ad Simon Wunderlich      2013-07-11  4814  				return;
73da7d5bab79ad Simon Wunderlich      2013-07-11  4815  			}
726d30f004a276 John Crispin          2021-06-28  4816  			beacon_data[bcn_offsets[i]] = count;
73da7d5bab79ad Simon Wunderlich      2013-07-11  4817  		}
af296bdb8da4d0 Michal Kazior         2014-06-05  4818  
af296bdb8da4d0 Michal Kazior         2014-06-05 @4819  		if (sdata->vif.type == NL80211_IFTYPE_AP && resp)
                                                                                                            ^^^^
Old code assumes "resp" can be NULL

726d30f004a276 John Crispin          2021-06-28  4820  			resp->data[resp_offsets[i]] = count;
73da7d5bab79ad Simon Wunderlich      2013-07-11  4821  	}
af296bdb8da4d0 Michal Kazior         2014-06-05  4822  	rcu_read_unlock();
1af586c9116cdf Andrei Otcheretianski 2014-05-09  4823  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

