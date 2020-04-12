Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 64D051A5BB8
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2020 03:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726813AbgDLBEF (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 11 Apr 2020 21:04:05 -0400
Received: from mga17.intel.com ([192.55.52.151]:43767 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726759AbgDLBEF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 11 Apr 2020 21:04:05 -0400
IronPort-SDR: KStBP010pH1d+zx8jIlQuXYXSyCv+84XhK3NDD4/B36qjasdX8FT0RzwjRZ65BjPqc7i/JWStu
 5yVcp98cRjgw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2020 18:04:05 -0700
IronPort-SDR: tNO7S9LV0NOGrgjPIoldBIBzXit1wpLT0GGxbF1grx7x49mAcrgm1eyKfgUQ/0mknXNZSvbtvk
 EZoKSj+j8FCQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,372,1580803200"; 
   d="scan'208";a="270740189"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 11 Apr 2020 18:04:04 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jNR2Z-0005yf-Ey; Sun, 12 Apr 2020 09:04:03 +0800
Date:   Sun, 12 Apr 2020 09:03:53 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Johannes Berg <johannes.berg@intel.com>
Cc:     kbuild-all@lists.01.org, linux-wireless@vger.kernel.org
Subject: [mac80211-next:netlink-validation 7/9]
 net/netlink/genetlink.c:1055:7: warning: Local variable 'err' shadows outer
 variable [shadowVariable]
Message-ID: <202004120951.ZyEVgD5E%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jberg/mac80211-next.git netlink-validation
head:   7285466f06c44e4080895c1b21a4323be9aaddb6
commit: 6c16e6c01eb1a3777f9caa976a9b993c28146cc7 [7/9] netlink: add infrastructure to expose policies to userspace

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>


cppcheck warnings: (new ones prefixed by >>)

>> net/netlink/genetlink.c:1055:7: warning: Local variable 'err' shadows outer variable [shadowVariable]
     int err = genlmsg_parse(cb->nlh, &genl_ctrl, tb,
         ^
   net/netlink/genetlink.c:1050:6: note: Shadowed declaration
    int err;
        ^
   net/netlink/genetlink.c:1055:7: note: Shadow variable
     int err = genlmsg_parse(cb->nlh, &genl_ctrl, tb,
         ^
   net/netlink/genetlink.c:480:68: warning: Clarify calculation precedence for '&' and '?'. [clarifyCalculation]
    enum netlink_validation validate = ops->validate & no_strict_flag ?
                                                                      ^
--
>> net/netlink/policy.c:106:28: warning: Local variable 'policy' shadows outer argument [shadowArgument]
     const struct nla_policy *policy;
                              ^
   net/netlink/policy.c:76:56: note: Shadowed declaration
   int netlink_policy_dump_start(const struct nla_policy *policy,
                                                          ^
   net/netlink/policy.c:106:28: note: Shadow variable
     const struct nla_policy *policy;
                              ^

vim +/err +1055 net/netlink/genetlink.c

  1045	
  1046	static int ctrl_dumppolicy(struct sk_buff *skb, struct netlink_callback *cb)
  1047	{
  1048		const struct genl_family *rt;
  1049		unsigned int fam_id = cb->args[0];
  1050		int err;
  1051	
  1052		if (!fam_id) {
  1053			struct nlattr *tb[CTRL_ATTR_MAX + 1];
  1054	
> 1055			int err = genlmsg_parse(cb->nlh, &genl_ctrl, tb,
  1056						genl_ctrl.maxattr,
  1057						genl_ctrl.policy, cb->extack);
  1058			if (err)
  1059				return err;
  1060	
  1061			if (!tb[CTRL_ATTR_FAMILY_ID] && !tb[CTRL_ATTR_FAMILY_NAME])
  1062				return -EINVAL;
  1063			if (tb[CTRL_ATTR_FAMILY_ID]) {
  1064				fam_id = nla_get_u16(tb[CTRL_ATTR_FAMILY_ID]);
  1065			} else {
  1066				rt = genl_family_find_byname(
  1067					nla_data(tb[CTRL_ATTR_FAMILY_NAME]));
  1068				if (!rt)
  1069					return -ENOENT;
  1070				fam_id = rt->id;
  1071			}
  1072		}
  1073	
  1074		rt = genl_family_find_byid(fam_id);
  1075		if (!rt)
  1076			return -ENOENT;
  1077	
  1078		if (!rt->policy)
  1079			return -ENODATA;
  1080	
  1081		err = netlink_policy_dump_start(rt->policy, rt->maxattr, &cb->args[1]);
  1082		if (err)
  1083			return err;
  1084	
  1085		while (netlink_policy_dump_loop(&cb->args[1])) {
  1086			void *hdr;
  1087			struct nlattr *nest;
  1088	
  1089			hdr = genlmsg_put(skb, NETLINK_CB(cb->skb).portid,
  1090					  cb->nlh->nlmsg_seq, &genl_ctrl,
  1091					  NLM_F_MULTI, CTRL_CMD_GETPOLICY);
  1092			if (!hdr)
  1093				goto nla_put_failure;
  1094	
  1095			if (nla_put_u16(skb, CTRL_ATTR_FAMILY_ID, rt->id))
  1096				goto nla_put_failure;
  1097	
  1098			nest = nla_nest_start(skb, CTRL_ATTR_POLICY);
  1099			if (!nest)
  1100				goto nla_put_failure;
  1101	
  1102			if (netlink_policy_dump_write(skb, cb->args[1]))
  1103				goto nla_put_failure;
  1104	
  1105			nla_nest_end(skb, nest);
  1106	
  1107			genlmsg_end(skb, hdr);
  1108			continue;
  1109	
  1110	nla_put_failure:
  1111			genlmsg_cancel(skb, hdr);
  1112			break;
  1113		}
  1114	
  1115		cb->args[0] = fam_id;
  1116		return skb->len;
  1117	}
  1118	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
